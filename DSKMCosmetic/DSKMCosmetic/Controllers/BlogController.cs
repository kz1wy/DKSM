using Microsoft.AspNetCore.Mvc;

namespace DSKMCosmetic.Controllers
{
    public class BlogController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
