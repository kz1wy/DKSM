using DSKMCosmetic.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System.Linq;

namespace DSKMCosmetic.Controllers
{
    public class ProductController : Controller
    {
        private readonly dksm_cosmeticContext _context;

        public ProductController(dksm_cosmeticContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            return View();
        }
        public IActionResult Details(string id)
        {
            var product = _context.Products.Include(x => x.Category).FirstOrDefault(x => x.ProductId.Equals(id));
            if (product == null)
            {
                return RedirectToAction("Index");
            }
            return View(product);
        }
    }
}
