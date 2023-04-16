using AspNetCoreHero.ToastNotification.Abstractions;
using DSKMCosmetic.Extension;
using DSKMCosmetic.Models;
using DSKMCosmetic.ModelViews;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using System.Linq;

namespace DSKMCosmetic.Controllers
{
    [Route("shoppingcart")]
    public class ShoppingCartController : Controller
    {
        private readonly dksm_cosmeticContext _context;
        private readonly INotyfService _notyfService;

        public ShoppingCartController(dksm_cosmeticContext context, INotyfService notyfService)
        {
            _context = context;
            _notyfService = notyfService;
        }

        public IActionResult Index()
        {
            var cartItems = HttpContext.Session.Get<List<CartItem>>("Cart") ?? new List<CartItem>();
            var viewModel = new ShoppingCartViewModel
            {
                CartItems = cartItems,
                CartTotal = cartItems.Sum(item => item.TotalPrice)
            };
            return View(viewModel);
        }

        [HttpPost("addtocart/{productId}")]
        public IActionResult AddToCart(string productId, int quantity)
        {
            var product = _context.Products.FirstOrDefault(p => p.ProductId == productId);

            if (product == null)
            {
                _notyfService.Error("Product not found");
                return RedirectToAction("Index");
            } 
            var cartItems = HttpContext.Session.Get<List<CartItem>>("Cart") ?? new List<CartItem>();
            var cartItem = cartItems.FirstOrDefault(item => item.ProductId == productId);

            if (cartItem == null)
            {
                cartItem = new CartItem
                {
                    ProductId = product.ProductId,
                    Quantity = quantity,
                    Product = product
                };
                cartItems.Add(cartItem);
            }
            else
            {
                cartItem.Quantity += quantity;
            }

            HttpContext.Session.Set("Cart", cartItems);
            _notyfService.Success("Item successfully added to cart");

            return RedirectToAction("Index");
        }

        [HttpPost("removefromcart/{productId}")]
        public IActionResult RemoveFromCart(string productId)
        {
            var cartItems = HttpContext.Session.Get<List<CartItem>>("Cart") ?? new List<CartItem>();
            var cartItem = cartItems.FirstOrDefault(item => item.ProductId == productId);

            if (cartItem != null)
            {
                if (cartItem.Quantity > 1)
                {
                    cartItem.Quantity--;
                }
                else
                {
                    cartItems.Remove(cartItem);
                }
            }

            HttpContext.Session.Set("Cart", cartItems);
            _notyfService.Success("Item removed from cart");

            return RedirectToAction("Index");
        }

    }
}
