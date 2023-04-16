using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

#nullable disable

namespace DSKMCosmetic.Models
{
    public partial class CartItem
    {

        public int CartItemId { get; set; }
        public int UserId { get; set; }
        public string ProductId { get; set; }
        public int Quantity { get; set; }

        [JsonIgnore]
        public virtual Product Product { get; set; }
        public virtual User User { get; set; }
        public double TotalPrice => Quantity * (double)Product.Price;
    }
}
