using DSKMCosmetic.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using PagedList;
using System;
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
        public IActionResult Index(int? page)
        {
            int pageIndex = page == null || page <= 0 ? 1 : page.Value;
            int pageSize = 5;

            var productList = _context.Products
                .AsNoTracking()
                .OrderByDescending(p => p.ProductId);

            int totalProducts = productList.Count();
            int totalPages = totalProducts > 0 ? (int)Math.Ceiling((double)totalProducts / pageSize) : 1;

            PagedList<Product> models = new PagedList<Product>(productList, pageIndex, pageSize);
            
            ViewBag.CurrentPage = pageIndex;
            ViewBag.TotalPages = totalPages;
            return View(models);
        }
        [Route("/products/list", Name = "ListProduct")]
        public IActionResult List(int page=1)
        {
            int pageSize = 5;
            var productList = _context.Products
                .AsNoTracking()
                .Include(p => p.Category)
                .OrderByDescending(p => p.ProductId);

            PagedList<Product> models = new PagedList<Product>(productList, page, pageSize);
            ViewBag.CurrentPage = page;

            return View(models);

        }
        [Route("product/{id}", Name = "ProductDetails")]
        public IActionResult Details(string id)
        {
            var product = _context.Products
                    .Include(p => p.Category)
                    .SingleOrDefault(p => p.ProductId == id);
            if (product == null)
            {
                return RedirectToAction("Index");
            }
            //maybe you will love it
            var lsProduct = _context.Products
                .AsNoTracking()
                .Where(x => x.CategoryId == product.CategoryId && x.ProductId != id)
                .OrderByDescending(x => x.ProductId)
                .Take(2)
                .ToList();
            ViewBag.Product = lsProduct;
            return View(product);
        }
    }
}
