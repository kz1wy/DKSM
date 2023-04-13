using DSKMCosmetic.Models;

namespace DSKMCosmetic.ModelViews
{
    public class CartItemViewModel
    {
        public int Id { get; set; }
        public int CartId { get; set; }
        public Product product { get; set; }
        public int amount { get; set; }
        public double TotalPrice => amount * (double)product.Price;
    }
}