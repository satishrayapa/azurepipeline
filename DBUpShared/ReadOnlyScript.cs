using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using DbUp.Engine;
using System.IO;

namespace DBUpgrade
{
    public class ReadOnlyScript : DbUp.Engine.SqlScript, IComparable<SqlScript>, IComparable
    {
        public ReadOnlyScript(string name, string contents): base(name, contents)
        {
        }

        new public static ReadOnlyScript FromFile(String path)
        {
            using (FileStream fileStream = new FileStream(path, FileMode.Open, FileAccess.Read))
            {
                var fileName = new FileInfo(path).Name;
                return FromStream(fileName, fileStream);
            }
        }

        new public static ReadOnlyScript FromStream(string scriptName, Stream stream)
        {
            using (StreamReader sr = new StreamReader(stream))
            {
                ReadOnlyScript s = new ReadOnlyScript(scriptName, sr.ReadToEnd());
                return s;
            }
        }

        public static IOrderedEnumerable<ReadOnlyScript> Order(IEnumerable<ReadOnlyScript> list)
        {
            var ord = from s in list
                      orderby s
                      select s;
            return ord;
        }

        private static int ExtractDate(string filename)
        {
            int result = int.MaxValue;
            string n = filename;
            int dtIndex = n.IndexOf("_201");
            if (dtIndex < 0)
                dtIndex = n.IndexOf("_202");

            if (dtIndex > 0)
            {
                dtIndex += 1;
                int dt2 = n.IndexOf("_", dtIndex);
                if (dt2 > 0)
                {
                    string str = n.Substring(dtIndex, dt2 - dtIndex);
                    //str.Dump();
                    int.TryParse(str, out result);
                }
            }
            return result;
        }

        public int CompareTo(SqlScript other)
        {
            if (other == null) return 1;
            //this < other = -1
            //this == other = 0
            //this > other = 1
            int result = 0;
            string thisName = this.Name.ToUpper();
            string otherName = other.Name.ToUpper();

            if (thisName.StartsWith("V") && thisName.Contains("__") && otherName.StartsWith("V") && otherName.Contains("__"))
            {
                result = CompareFileVersion(thisName, otherName);
            }
            else if (thisName.StartsWith("V") && thisName.Contains("__") && !(otherName.StartsWith("V") && otherName.Contains("__")))
                result = -1;
            else if (!(thisName.StartsWith("V") && thisName.Contains("__")) && otherName.StartsWith("V") && otherName.Contains("__"))
                result = 1;
            else if (thisName.StartsWith("R") && thisName.Contains("__") && otherName.StartsWith("R") && otherName.Contains("__"))
            {
                result = this.Name.CompareTo(other.Name);
            }
            else if (thisName.StartsWith("R") && thisName.Contains("__") && !(otherName.StartsWith("R") && otherName.Contains("__")))
                result = -1;
            else if (!(thisName.StartsWith("R") && thisName.Contains("__")) && otherName.StartsWith("R") && otherName.Contains("__"))
                result = 1;
            else
            {
                if (thisName.Contains("CREATE_") && otherName.Contains("CREATE_"))
                {
                    result = CompareFileDate(thisName, otherName);
                }
                else if (thisName.Contains("CREATE_") && !otherName.Contains("CREATE_"))
                    result = -1;
                else if (!thisName.Contains("CREATE_") && otherName.Contains("CREATE_"))
                    result = 1;
                else if (thisName.Contains("ALTER_") && otherName.Contains("ALTER_"))
                {
                    result = CompareFileDate(this.Name, other.Name);
                }
                else if (thisName.Contains("ALTER_") && !otherName.Contains("ALTER_"))
                    result = -1;
                else if (!thisName.Contains("ALTER_") && otherName.Contains("ALTER_"))
                    result = 1;
            }
            return result;
        }

        private int CompareFileVersion(string file1, string file2)
        {
            int index = file1.IndexOf("__");
            string ver1 = file1.Substring(1, index - 1);

            index = file2.IndexOf("__");
            string ver2 = file2.Substring(1, index - 1);

            int result = CompareVersion(ver1, ver2);
            if (result == 0)
                result = file1.CompareTo(file2);
            return result;
        }
        
        private int CompareVersion(string version1, string version2)
        {
            int index1 = version1.IndexOf(".");
            int index2 = version2.IndexOf(".");

            if (index1 == -1 && version1.Length > 0)
                index1 = version1.Length;
            if (index2 == -1 && version2.Length > 0)
                index2 = version2.Length;

            if (index1 == -1 && index2 == -1)
                return 0;
            else if (index1 == -1)
                return -1;
            else if (index2 == -1)
                return 1;

            string part1 = version1.Substring(0, index1);
            int v1 = int.Parse(part1);
            string part2 = version2.Substring(0, index2);
            int v2 = int.Parse(part2);

            int result = v1.CompareTo(v2);
            if (result == 0)
            {
                if (index1 + 1 > version1.Length && index2 + 1 > version2.Length)
                    return 0;
                else if (index1 + 1 > version1.Length)
                    return -1;
                else if (index2 + 1 > version2.Length)
                    return 1;
                result = CompareVersion(version1.Substring(index1 + 1), version2.Substring(index2 + 1));
            }
            return result;
        }

        private int CompareFileDate(string file1, string file2)
        {
            int dt1 = ExtractDate(file1);
            int dt2 = ExtractDate(file2);
            int result = dt1.CompareTo(dt2);
            if (result == 0)
                result = file1.CompareTo(file2);
            return result;
        }

        public int CompareTo(object obj)
        {
            if (obj == null) return 1;

            SqlScript other = obj as SqlScript;
            if (other != null)
                return this.CompareTo(other);
            else
                throw new ArgumentException("Object is not a SqlScript");
        }
    }
}
