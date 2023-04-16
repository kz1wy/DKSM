using DSKMCosmetic.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;

namespace DSKMCosmetic.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class AdminOrdersController : Controller
    {
        private readonly dksm_cosmeticContext _context;

        public AdminOrdersController(dksm_cosmeticContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            List<Order> orderList = _context.Orders
                                    .AsNoTracking()
                                    .Where(o => o.ShippingAddress != null)
                                    .OrderByDescending(o => o.OrderDate)
                                    .ToList();
            ViewBag.Orders = orderList;
            return View(orderList);
        }
    }
}
