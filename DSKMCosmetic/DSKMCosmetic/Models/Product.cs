using System;
using System.Collections.Generic;

#nullable disable

namespace DSKMCosmetic.Models
{
    public partial class Product
    {
        public Product()
        {
            CartItems = new HashSet<CartItem>();
            OrderItems = new HashSet<OrderItem>();
        }

        public string ProductId { get; set; }
        public string CategoryId { get; set; }
        public string ProductName { get; set; }
        public string BrandName { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public string Size { get; set; }
        public string ImageUrl { get; set; }

        public virtual Category Category { get; set; }
        public virtual ICollection<CartItem> CartItems { get; set; }
        public virtual ICollection<OrderItem> OrderItems { get; set; }
    }
}
