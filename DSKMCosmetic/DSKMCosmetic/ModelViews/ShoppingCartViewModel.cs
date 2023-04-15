using DSKMCosmetic.Models;
using System.Collections.Generic;

namespace DSKMCosmetic.ModelViews
{
    public class ShoppingCartViewModel
    {
        public List<CartItem> CartItems { get; set; }
        public double CartTotal { get; set; }
        public int Quantity { get; set; }

        public virtual Product Product { get; set; }
        public virtual User User { get; set; }
        public double TotalPrice => Quantity * (double)Product.Price;
    }
}