using AspNetCoreHero.ToastNotification.Abstractions;
using DSKMCosmetic.Extension;
using DSKMCosmetic.Helper;
using DSKMCosmetic.Models;
using DSKMCosmetic.ModelViews;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Security.Claims;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using static DSKMCosmetic.Models.User;

namespace DSKMCosmetic.Controllers
{
    [Authorize]
    public class AccountsController : Controller
    {
        private readonly dksm_cosmeticContext _context;
        private readonly ILogger<AccountsController> _logger;
        public AccountsController(ILogger<AccountsController> logger, dksm_cosmeticContext context)
        {
            _logger = logger;
            _context = context;
        }
        [Route("my-account.html", Name = "DashBoard")]
        public IActionResult Dashboard()
        {
            var id = HttpContext.Session.GetString("UserId");
            if (id == null)
                return RedirectToAction("Login");

            var user = _context.Users
                    .Include(u => u.Orders)
                    .AsNoTracking()
                    .SingleOrDefault(x => x.UserId == int.Parse(id));
            
            if (user != null)
            {
                var orders = user.Orders.ToList();
                ViewBag.OrderList = orders;
                return View(user);
            }
            return RedirectToAction("Login");
        }

        [HttpGet]
        [AllowAnonymous]
        [Route("register.html", Name = "Register")]
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        [Route("register.html", Name = "Register")]
        public async Task<IActionResult> Register(RegisterViewModel model)
        {
            // Check if the model state is valid before proceeding
            if (!ModelState.IsValid)
            {
                foreach (var modelStateEntry in ModelState.Values)
                {
                    foreach (var error in modelStateEntry.Errors)
                    {
                        Console.WriteLine($"Error: {error.ErrorMessage}");
                    }
                }
            }

            // Generate a random salt to add to the user's password
          
            // Create a new User object with the data from the form
            User user = new User
            {
                UserId = Utilities.GenerateUserId(_context),
                FirstName = model.FirstName,
                LastName = model.LastName,
                Email = model.Email,
                Password = (model.Password).ToMd5(),
                Role = "user"
            };

            try
            {
                // Check if the email already exists
                var existingUser = await _context.Users.FirstOrDefaultAsync(u => u.Email == user.Email);
                if (existingUser != null)
                {
                    ModelState.AddModelError("Email", "Email already exists .");
                    return View(model);
                }
                // Add the new user to the database and save changes
                _context.Users.Add(user);
                await _context.SaveChangesAsync();

                // Set the user ID in the session
                HttpContext.Session.SetString("UserId", user.UserId.ToString());

                // Create a list of claims for the user's identity
                var claims = new List<Claim>
                {
                    new Claim("FirstName", user.FirstName),
                    new Claim("LastName", user.LastName),
                    new Claim("UserId", user.UserId.ToString())
                };

                // Create a new identity with the user's claims
                ClaimsIdentity claimsIdentity = new ClaimsIdentity(claims, "login");
                ClaimsPrincipal claimsPrincipal = new ClaimsPrincipal(claimsIdentity);

                // Sign in the user and redirect to the login page
                await HttpContext.SignInAsync(claimsPrincipal);
                return RedirectToAction("Login", "Accounts");
            }
            catch (DbUpdateException ex)
            {
                // Check if the exception is due to a duplicate email
                if (ex.InnerException is SqlException sqlException && sqlException.Number == 2601)
                {
                    ModelState.AddModelError("Email", "Email already exists in the database.");
                }
                else
                {
                    ModelState.AddModelError("", $"An error occurred while registering: {ex.Message}");
                }

                return View(model);
            }

        }

        [HttpGet]
        [AllowAnonymous]
        [Route("login.html", Name = "Login")]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [Route("login.html", Name = "Login")]
        public async Task<IActionResult> Login(LoginViewModel model, string returnUrl = null)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    // Check if the email is valid
                    bool validEmail = Utilities.IsValidEmail(model.Email);
                    if (!validEmail)
                        return View(model);

                    // Find the user with the given email address
                    User user = null;
                    try
                    {
                        user = await _context.Users.SingleAsync(u => u.Email == model.Email);
                    }
                    catch (InvalidOperationException)
                    {
                        // User not found
                        ModelState.AddModelError("", "Invalid email or password");
                        return View(model);
                    }

                    // Check if the user exists and the password is correct
                    if (user != null && user.Password == model.Password.ToMd5())
                    {
                        // Create the claims for the authenticated user
                        var claims = new List<Claim>
                        {
                            new Claim(ClaimTypes.Name, user.Email),
                            new Claim("FirstName", user.FirstName),
                            new Claim("LastName", user.LastName),
                            new Claim("UserId", user.UserId.ToString())
                        };

                        // Add role claim if user is admin
                        if (user.Role == "admin")
                        {
                            claims.Add(new Claim(ClaimTypes.Role, "admin"));
                        }

                        // Create the identity for the authenticated user
                        var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

                        // Create the principal for the authenticated user
                        var principal = new ClaimsPrincipal(identity);

                        // Sign in the user
                        await HttpContext.SignInAsync(principal);

                        // Set the user id in the session
                        HttpContext.Session.SetString("UserId", user.UserId.ToString());

                        // Redirect to the appropriate page based on user role
                        if (user.Role == "admin")
                        {
                            return RedirectToAction("Index", "Home", new { area = "Admin" });
                        }
                        else
                        {
                            if (!string.IsNullOrEmpty(returnUrl) && Url.IsLocalUrl(returnUrl))
                            {
                                return Redirect(returnUrl);
                            }
                            else
                            {
                                return RedirectToAction("Dashboard", "Accounts");
                            }
                        }
                    }
                    else
                    {
                        // User not found or password incorrect
                        ModelState.AddModelError("", "Invalid email or password");
                    }

                }
            }
            catch (Exception ex)
            {
                // Error occurred
                ModelState.AddModelError("", $"An error occurred while logging in: {ex.Message}");
            }
            // If we got this far, something failed, redisplay form
            return View(model);
        }

        [HttpGet]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            HttpContext.Session.Remove("UserId");
            return RedirectToAction("Index", "Home");
        }

    }
}
