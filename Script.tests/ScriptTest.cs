using System;
using System.Collections.Generic;
using System.IO;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Linq;
using System.Text.RegularExpressions;
using System.Text;

namespace Script.tests
{
    [TestClass]
    public class ScriptTest
    {
        [TestMethod]
        public void TestInvalidUTF8Characters()
        {
            var root = GetPath();
            foreach (var path in GetScriptDirectories())
            {
                TestScriptsInPathUTF8(root, path);
            }
        }

        [TestMethod]
        public void TestUniqueVersionPrefix()
        {
            var root = GetPath();

            string[] knownPaths = new string[] { 
                Path.Combine(root, "Security"),
                Path.Combine(root, "Application"),
                Path.Combine(root, "DTS_BATCH_QUEUE"),
                Path.Combine(root, "GTN_Doc"),
                Path.Combine(root, "GTN_Events"),
                Path.Combine(root, "GTN_Log"),
                Path.Combine(root, "IP_API"),
                Path.Combine(root, "IP_ExternalDocLinks"),
                Path.Combine(root, "ReportServiceQueue"),
                Path.Combine(root, "USABI"),
                Path.Combine(root, "Biblioteca")
            };
            foreach (var path in GetScriptDirectories().Where(d => !knownPaths.Contains(d)) )
            {
                TestScriptsInPath(root, path);
            }
        }

        [TestMethod]
        public void TestSecurityUniqueVersionPrefix()
        {
            var root = GetPath();
            var path = Path.Combine(root, "Security");
            TestScriptsInPath(root, path);
        }

        [TestMethod]
        public void TestApplicationUniqueVersionPrefix()
        {
            var root = GetPath();
            var path = Path.Combine(root, "Application");
            TestScriptsInPath(root, path);
        }

        [TestMethod]
        public void TestDTS_BATCH_QUEUEUniqueVersionPrefix()
        {
            var root = GetPath();
            var path = Path.Combine(root, "DTS_BATCH_QUEUE");
            TestScriptsInPath(root, path);
        }

        [TestMethod]
        public void TestGTN_DocUniqueVersionPrefix()
        {
            var root = GetPath();
            var path = Path.Combine(root, "GTN_Doc");
            TestScriptsInPath(root, path);
        }

        [TestMethod]
        public void TestGTN_EventsUniqueVersionPrefix()
        {
            var root = GetPath();
            var path = Path.Combine(root, "GTN_Events");
            TestScriptsInPath(root, path);
        }

        [TestMethod]
        public void TestGTN_LogUniqueVersionPrefix()
        {
            var root = GetPath();
            var path = Path.Combine(root, "GTN_Log");
            TestScriptsInPath(root, path);
        }

        [TestMethod]
        public void TestIP_APIUniqueVersionPrefix()
        {
            var root = GetPath();
            var path = Path.Combine(root, "IP_API");
            TestScriptsInPath(root, path);
        }

        [TestMethod]
        public void TestIP_ExternalDocLinksUniqueVersionPrefix()
        {
            var root = GetPath();
            var path = Path.Combine(root, "IP_ExternalDocLinks");
            TestScriptsInPath(root, path);
        }

        [TestMethod]
        public void TestReportServiceQueueUniqueVersionPrefix()
        {
            var root = GetPath();
            var path = Path.Combine(root, "ReportServiceQueue");
            TestScriptsInPath(root, path);
        }

        [TestMethod]
        public void TestUSABIUniqueVersionPrefix()
        {
            var root = GetPath();
            var path = Path.Combine(root, "USABI");
            TestScriptsInPath(root, path);
        }

        [TestMethod]
        public void TestBibliotecaUniqueVersionPrefix()
        {
            var root = GetPath();
            var path = Path.Combine(root, "Biblioteca");
            TestScriptsInPath(root, path);
        }

        private void TestScriptsInPath(string root, string path)
        {
            var missing__ = (from f in Directory.EnumerateFiles(path, "V*.sql", SearchOption.AllDirectories)
                           let ff = Path.GetFileName(f)
                            where !ff.Contains("__")
                           select ff).ToList();
            Assert.AreEqual(0, missing__.Count, $"Scripts missing double underscore in {path.Replace(root, "")} folder. Versions: {String.Join(", ", missing__)}");

            var versions = from f in Directory.EnumerateFiles(path, "V*__*.sql", SearchOption.AllDirectories)
                            let ff = Path.GetFileName(f)
                            select new { version = ff.Substring(0, ff.IndexOf("__")), name = ff };

            var dups = versions.GroupBy(x => x.version)
                            .Where(g => g.Count() > 1)
                            .Select(y => y.Key)
                            .ToList();

            Assert.AreEqual(0, dups.Count, $"Multiple scripts with same version not allowed in {path.Replace(root, "")} folder. Versions: {String.Join(", ", dups)}");

            var badversions = versions.Where(v =>
                {
                    var m = Regex.Match(v.version, @"V((\d)*(\.)*)*");
                    return !m.Success || m.Value != v.version;
                }).ToList();
            Assert.AreEqual(0, badversions.Count, $"Scripts with bad version format {path.Replace(root, "")} folder. Versions: {String.Join(", ", badversions.Select(b => b.version))}");
        }

        private void TestScriptsInPathUTF8(string root, string path)
        {
            var files = from f in Directory.EnumerateFiles(path, "*.sql", SearchOption.AllDirectories)
                           select f;

            string pattern = ".*�.*";
            Regex reg = new Regex(pattern);
            foreach (var filepath in files)
            {
                if (filepath.Contains("__baseline"))
                    continue;

                using (var st = File.OpenRead(filepath))
                {
                    using (TextReader r = new StreamReader(st, Encoding.UTF8))
                    {
                        var s = r.ReadToEnd();
                        if (s.Contains("�"))
                        {
                            Assert.Fail($"Invalid UTF8 character in {filepath.Replace(root, "")}: {reg.Matches(s)[0].Value}.");
                        }
                    }
                }
            }

            
        }

        private string GetPath()
        {
            var dir = @"..\..\..\Database\";
            var path = Environment.GetEnvironmentVariable("Build_SourcesDirectory");
            if (path != null)
            {
                dir = Path.Combine(path, "Database");
            }
            return Path.GetFullPath(dir);
        }

        private IEnumerable<string> GetScriptDirectories()
        {
            var path = GetPath();
            foreach( string dir in Directory.EnumerateDirectories(path))
            {
                if(Directory.Exists(Path.Combine(dir, "19.4")) || Directory.Exists(Path.Combine(dir, "20.2")))
                {
                    yield return dir;
                }
            }
        }
    }
}
