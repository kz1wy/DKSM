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
    public class ShoppingCartController : Controller
    {
        private readonly dksm_cosmeticContext _context;
        public INotyfService _notifyService { get; }
        public ShoppingCartController(dksm_cosmeticContext context, INotyfService notyfService)
        {
            _context = context;
            _notifyService = notyfService;
        }
        public List<CartItem> Cart
        {
            get
            {
                var cart = HttpContext.Session.Get<List<CartItem>>("Cart");
                if (cart == default(List<CartItem>))
                {
                    cart = new List<CartItem>();
                }
                return cart;
            }
        }

        [HttpPost]
        [Route("cart/add")]
        // Add item to cart
        public IActionResult AddToCart(string id, int? amount)
        {
            try
            {
                List<CartItem> cart = Cart;
                // Check if item is already in cart
                CartItem item = cart.SingleOrDefault(i => i.Product.ProductId == id);
                if (item != null)
                {
                    if (amount.HasValue)
                    {
                        item.Quantity = amount.Value;
                    }
                    else
                    {
                        item.Quantity++;
                    }
                }
                else
                {
                    // Get product from database
                    Product product = _context.Products.FirstOrDefault(p => p.ProductId == id);
                    item = new CartItem
                    {
                        Quantity = amount.HasValue ? amount.Value : 1,
                        Product = product
                    };
                    cart.Add(item);
                }

                // Save cart items to session
                HttpContext.Session.Set<List<CartItem>>("CartItems", cart);

                return Json(new { success = true });
            }
            catch
            {
                return Json(new { success = false });
            }
        }

        [HttpPost]
        [Route("cart/remove")]
        public IActionResult RemoveFromCart(string productId)
        {
            try
            {
                // Get the cart from the session
                List<CartItem> cart = Cart;

                CartItem cartItem = cart.SingleOrDefault(ci => ci.Product.ProductId == productId);

                if (cartItem != null)
                {
                    // If the cart item is found, remove it from the cart
                    cart.Remove(cartItem);

                }

                HttpContext.Session.Set<List<CartItem>>("CartItems", cart);
                return Json(new { success = true });
            }
            catch
            {
                return Json(new { success = false });
            }
        }

        [Route("/cart.html", Name = "Cart")]
        // Get cart items from session and display in view
        public IActionResult Index()
        {
            List<string> lsProductIds = new List<string>();
            var lsCart = Cart;
            //foreach (var item in lsCart)
            //{
            //    lsProductIds.Add(item.Product.ProductId);
            //}
            return View(Cart);
        }
    }
}
