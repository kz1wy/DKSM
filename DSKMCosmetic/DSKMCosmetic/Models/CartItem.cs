using System;
using System.Collections.Generic;

#nullable disable

namespace DSKMCosmetic.Models
{
    public partial class CartItem
    {
        public int CartItemId { get; set; }
        public int UserId { get; set; }
        public string ProductId { get; set; }
        public int Quantity { get; set; }

        public virtual Product Product { get; set; }
        public virtual User User { get; set; }
    }
}
