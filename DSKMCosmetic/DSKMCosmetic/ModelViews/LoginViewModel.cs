using System;
using System.ComponentModel.DataAnnotations;
using System.Xml.Linq;

namespace DSKMCosmetic.ModelViews
{
    public class LoginViewModel
    {
        [Key]
        [MaxLength(100)]
        [Required(ErrorMessage = "Email is required")]
        [Display(Name = "Email")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Password is required")]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        [MinLength(6, ErrorMessage = "Password must have at least 6 characters")]
        public string Password { get; set; }

    }
}
