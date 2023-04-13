using DSKMCosmetic.Models;
using System;
using System.Linq;
using System.Security.Cryptography;

namespace DSKMCosmetic.Helper
{
    public static class Utilities
    {
        public static string GetRandomKey(int length = 6)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var randomBytes = new byte[length];
            using (var rng = new RNGCryptoServiceProvider())
            {
                rng.GetBytes(randomBytes);
            }
            var result = new char[length];
            for (int i = 0; i < length; i++)
            {
                result[i] = chars[randomBytes[i] % chars.Length];
            }
            return new string(result);
        }
        public static bool IsValidEmail(string Email)
        {
            if (Email.Trim().EndsWith("."))
            {
                return false;
            }
            try
            {
                var addr = new System.Net.Mail.MailAddress(Email);
                return addr.Address == Email;
            }
            catch
            {
                return false;
            }
        }
        public static int GenerateUserId(dksm_cosmeticContext context)
        {
            int userId = 1;
            bool isUnique = false;

            // Keep generating new user IDs until a unique one is found
            while (!isUnique)
            {
                // Generate a random 6-digit number
                Random random = new Random();
                userId = random.Next(1, 999999);

                // Check if the user ID already exists in the database
                isUnique = !context.Users.Any(u => u.UserId == userId);
            }

            return userId;
        }

    }
}
