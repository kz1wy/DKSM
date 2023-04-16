using AspNetCoreHero.ToastNotification.Abstractions;
using DSKMCosmetic.Extension;
using DSKMCosmetic.Helper;
using DSKMCosmetic.Models;
using DSKMCosmetic.ModelViews;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;

namespace DSKMCosmetic.Controllers
{
    public class CheckoutController : Controller
    {
        private readonly dksm_cosmeticContext _context;
        private readonly INotyfService _notyfService;

        public CheckoutController(dksm_cosmeticContext context, INotyfService notyfService)
        {
            _context = context;
            _notyfService = notyfService;
        }
        public IActionResult Index()
        {
            string userId = HttpContext.User.FindFirstValue("UserId");
            var user = _context.Users.SingleOrDefault(u => u.UserId.ToString() == userId);
            if (user == null)
            {
                // Handle the case where the user does not exist
                return NotFound();
            }

            // Retrieve the current user's cart items
            var cartItems = HttpContext.Session.Get<List<CartItem>>("Cart");

            // Calculate the total amount of the order
            decimal totalAmount = cartItems.Sum(item => item.Product.Price * item.Quantity);

            var model = new OrderViewModel
            {
                User = user,
                CartItems = cartItems, // Add the cart items to the OrderViewModel
                TotalAmount = totalAmount // Set the total amount of the order
            };

            return View(model);
        }

        [HttpPost]
        public IActionResult Index(OrderViewModel model)
        {
            // Retrieve the current user's cart items from the database
            var cartItems = HttpContext.Session.Get<List<CartItem>>("Cart");

            // Calculate the total amount of the order
            decimal totalAmount = cartItems.Sum(item => item.Product.Price * item.Quantity);
            string userId = HttpContext.User.FindFirstValue("UserId");
            var user = _context.Users.SingleOrDefault(u => u.UserId.ToString() == userId);
            // Create a new order in the database

            var order = new Order
            {
                OrderId = Utilities.GenerateUserId(_context),
                UserId = int.Parse(userId),
                OrderDate = DateTime.Now,
                TotalAmount = totalAmount,
                Status = "Pending",
                ShippingAddress = model.ShippingAddress == null? "abc 123" : model.ShippingAddress.ToString(),
            };
            _context.Orders.Add(order);
            _context.SaveChanges();

            // Create order items for each cart item and add them to the database
            foreach (var cartItem in cartItems)
            {
                var orderItem = new OrderItem
                {
                    OrderItemId = Utilities.GenerateUserId(_context),
                    OrderId = order.OrderId,
                    ProductId = cartItem.ProductId,
                    Quantity = cartItem.Quantity,
                    Price = cartItem.Product.Price
                };
                _context.OrderItems.Add(orderItem);
            }
            _context.SaveChanges();
            _notyfService.Success("Successfully Placed Order");

            // Add the user's last name to the OrderViewModel
            var orderViewModel = new OrderViewModel
            {
                OrderId = order.OrderId,
                User = user,
                OrderDate = order.OrderDate,
                TotalAmount = order.TotalAmount,
                Status = order.Status,
            };

            // Redirect the user to the order confirmation page
            return RedirectToAction("Dashboard", "Accounts");
        }

    }
}
