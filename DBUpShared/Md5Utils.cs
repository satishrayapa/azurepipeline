using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace DBUpgrade
{
    public class Md5Utils
    {
        private const string CryptoType = "MD5";

        public static string Md5EncodeString(string input)
        {
            var encodedInput = new UTF8Encoding().GetBytes(input);
            var hash = ((HashAlgorithm)CryptoConfig.CreateFromName(CryptoType)).ComputeHash(encodedInput);
            var encoded = BitConverter.ToString(hash)
                .ToLower();// make lowercase

            return encoded;
        }
    }
}
