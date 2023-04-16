using DSKMCosmetic.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DSKMCosmetic.ModelViews
{
    public class OrderViewModel
    {
        public int OrderId { get; set; }
        public User User { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public string Status { get; set; }

        [Required(ErrorMessage = "Please provide shipping address.")]
        public string ShippingAddress { get; set; }

        public List<CartItem> CartItems { get; set; }
    }
}
