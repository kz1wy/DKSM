using System;
using System.Collections.Generic;

#nullable disable

namespace DSKMCosmetic.Models
{
    public partial class User
    {
        public User()
        {
            CartItems = new HashSet<CartItem>();
            Orders = new HashSet<Order>();
        }

        public int UserId { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }

        public virtual ICollection<CartItem> CartItems { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
    }
}
