using DSKMCosmetic.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;

namespace DSKMCosmetic.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class SearchController : Controller
    {
        private readonly dksm_cosmeticContext _context;

        public SearchController(dksm_cosmeticContext context)
        {
            _context = context;
        }

        //GET: Search/FindProduct
        [HttpPost]
        public IActionResult FindProduct(string keyword)
        {
            List<Product> products = _context.Products
                .AsNoTracking()
                .Include(p => p.Category)
                .OrderBy(p => p.ProductName)
                .ToList();

            if (!string.IsNullOrWhiteSpace(keyword))
            {
                keyword = keyword.ToLower(); // Convert keyword to lowercase

                products = products
                    .Where(p => p.ProductName.ToLower().Contains(keyword)) // Convert ProductName to lowercase
                    .Take(5)
                    .ToList();
            }

            return PartialView("ListProductsSearchPartial", products);
        }




    }
}
