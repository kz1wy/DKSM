using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using DSKMCosmetic.ModelViews;

#nullable disable

namespace DSKMCosmetic.Models
{
    public partial class dksm_cosmeticContext : DbContext
    {
        public dksm_cosmeticContext()
        {
        }

        public dksm_cosmeticContext(DbContextOptions<dksm_cosmeticContext> options)
            : base(options)
        {
        }

        public virtual DbSet<CartItem> CartItems { get; set; }
        public virtual DbSet<Category> Categories { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<OrderItem> OrderItems { get; set; }
        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<User> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Server=CLOUD;Database=dksm_cosmetic;User ID=duy;pwd='cho123456789';Integrated Security=True;");
                optionsBuilder.EnableSensitiveDataLogging();
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "SQL_Latin1_General_CP1_CI_AS");

            modelBuilder.Entity<CartItem>(entity =>
            {
                entity.ToTable("cart_items");

                entity.Property(e => e.CartItemId)
                    .ValueGeneratedNever()
                    .HasColumnName("cart_item_id");

                entity.Property(e => e.ProductId)
                    .IsRequired()
                    .HasMaxLength(6)
                    .IsUnicode(false)
                    .HasColumnName("product_id");

                entity.Property(e => e.Quantity).HasColumnName("quantity");

                entity.Property(e => e.UserId).HasColumnName("user_id");

                entity.HasOne(d => d.Product)
                    .WithMany(p => p.CartItems)
                    .HasForeignKey(d => d.ProductId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__cart_item__produ__2D27B809");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.CartItems)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__cart_item__user___2C3393D0");
            });

            modelBuilder.Entity<Category>(entity =>
            {
                entity.ToTable("categories");

                entity.Property(e => e.CategoryId)
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasColumnName("category_id");

                entity.Property(e => e.CategoryName)
                    .IsRequired()
                    .HasMaxLength(30)
                    .HasColumnName("category_name");
            });

            modelBuilder.Entity<Order>(entity =>
            {
                entity.ToTable("orders");

                entity.Property(e => e.OrderId)
                    .ValueGeneratedNever()
                    .HasColumnName("order_id");

                entity.Property(e => e.OrderDate)
                    .HasColumnType("datetime")
                    .HasColumnName("order_date");

                entity.Property(e => e.ShippingAddress)
                    .IsRequired()
                    .HasMaxLength(500)
                    .IsUnicode(false)
                    .HasColumnName("shipping_address");

                entity.Property(e => e.Status)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasColumnName("status");

                entity.Property(e => e.TotalAmount)
                    .HasColumnType("decimal(10, 2)")
                    .HasColumnName("total_amount");

                entity.Property(e => e.UserId).HasColumnName("user_id");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__orders__user_id__300424B4");
            });

            modelBuilder.Entity<OrderItem>(entity =>
            {
                entity.ToTable("order_items");

                entity.Property(e => e.OrderItemId)
                    .ValueGeneratedNever()
                    .HasColumnName("order_item_id");

                entity.Property(e => e.OrderId).HasColumnName("order_id");

                entity.Property(e => e.Price)
                    .HasColumnType("decimal(10, 3)")
                    .HasColumnName("price");

                entity.Property(e => e.ProductId)
                    .IsRequired()
                    .HasMaxLength(6)
                    .IsUnicode(false)
                    .HasColumnName("product_id");

                entity.Property(e => e.Quantity).HasColumnName("quantity");

                entity.HasOne(d => d.Order)
                    .WithMany(p => p.OrderItems)
                    .HasForeignKey(d => d.OrderId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__order_ite__order__32E0915F");

                entity.HasOne(d => d.Product)
                    .WithMany(p => p.OrderItems)
                    .HasForeignKey(d => d.ProductId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__order_ite__produ__33D4B598");
            });

            modelBuilder.Entity<Product>(entity =>
            {
                entity.ToTable("products");

                entity.Property(e => e.ProductId)
                    .HasMaxLength(6)
                    .IsUnicode(false)
                    .HasColumnName("product_id");

                entity.Property(e => e.BrandName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("brand_name");

                entity.Property(e => e.CategoryId)
                    .IsRequired()
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasColumnName("category_id");

                entity.Property(e => e.Description)
                    .HasMaxLength(2500)
                    .HasColumnName("description");

                entity.Property(e => e.ImageUrl)
                    .IsRequired()
                    .HasMaxLength(150)
                    .IsUnicode(false)
                    .HasColumnName("image_url");

                entity.Property(e => e.Price)
                    .HasColumnType("decimal(10, 3)")
                    .HasColumnName("price");

                entity.Property(e => e.ProductName)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("product_name");

                entity.Property(e => e.Size)
                    .IsRequired()
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasColumnName("size");

                entity.HasOne(d => d.Category)
                    .WithMany(p => p.Products)
                    .HasForeignKey(d => d.CategoryId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__products__catego__29572725");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("users");

                entity.HasIndex(e => e.Email, "UQ__users__AB6E6164027742A8")
                    .IsUnique();

                entity.Property(e => e.UserId)
                    .ValueGeneratedNever()
                    .HasColumnName("user_id");

                entity.Property(e => e.Address)
                    .HasMaxLength(300)
                    .HasColumnName("address");

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("email");

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("first_name");

                entity.Property(e => e.LastName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("last_name");

                entity.Property(e => e.Password)
                    .IsRequired()
                    .HasMaxLength(16)
                    .IsUnicode(false)
                    .HasColumnName("password");

                entity.Property(e => e.Phone)
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasColumnName("phone");

            });
            

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);

        public DbSet<DSKMCosmetic.ModelViews.RegisterViewModel> RegisterViewModel { get; set; }

    }
}
