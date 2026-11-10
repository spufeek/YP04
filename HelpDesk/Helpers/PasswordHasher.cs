using System;
using System.Security.Cryptography;
using System.Text;

namespace HelpDesk.Helpers
{
    
    public static class PasswordHasher
    {
        
        public static string ComputeHash(string password)
        {
            if (string.IsNullOrEmpty(password))
            {
                throw new ArgumentException("Пароль не может быть пустым.", nameof(password));
            }

            byte[] bytes = SHA256.HashData(Encoding.UTF8.GetBytes(password));

            return Convert.ToHexString(bytes);
        }

        
        public static bool Verify(string password, string hash)
        {
            if (string.IsNullOrEmpty(password) || string.IsNullOrEmpty(hash))
            {
                return false;
            }

            return string.Equals(ComputeHash(password), hash, StringComparison.OrdinalIgnoreCase);
        }
    }
}
