using DSKMCosmetic.Models;
using System;
using System.Collections.Generic;

namespace DSKMCosmetic.ModelViews
{
    public class OrderViewModel
    {
        public int OrderId { get; set; }
        public User User { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public string Status { get; set; }
        public string ShippingAddress { get; set; }

        public List<CartItem> CartItems { get; set; }
    }
}
