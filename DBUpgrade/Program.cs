using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NDesk.Options;
using DbUp;
using DbUp.Engine.Transactions;
using DbUp.Support.SqlServer;
using DbUp.Engine.Output;
using System.IO;

namespace DBUpgrade
{
    class Program
    {
        //create dummy fields so ILMerge will fail if the libraries are not marked to merge in 
        //use <IlMerge>True</IlMerge> in the csproj file
        private dugUtilities.CConnectionInfo dummy;
        private IntegrationPoint.Cache.MemoryFileInfo dummy2;
        private dugSQL.Utility dummy3;

        static int Main(string[] args)
        {
            bool dry = false;
            var connectionString = "";
            var version = "";
            var map = "";
            var partnerID = "";
            var allPartners = false;
            var noPartners = false;
            var skipSecurityDB = false;
            var oldMode = !newMethod(new DirectoryInfo("."));
            var updatePartners = false;
            DBConnections.DBType? type = DBConnections.DBType.GTM;
            var output = false;

            bool show_help = false;

            var optionSet = new OptionSet() {
                { "v|version=", "required: version to apply (eg 14.3, 14.4)", v => version = v},
                { "m|map=", "required: mapping from folder to dbconfig name (<folder>=<dbConfig name>;<folder>=<name>)", m => map = m},
                { "p|partnerID=", "partnerID to apply", p => partnerID = p},
                { "ap|allPartners",  "run for all partners in the security db", v => allPartners = v != null },
                { "np|noPartners",  "run for no partners in the security db", v => noPartners = v != null },
                { "ss|skipSecurityDB",  "don't update the security db", v => skipSecurityDB = v != null },
                { "old|oldMode",  "don't update the security db", v => oldMode = v != null },
                { "h|help",  "show this message and exit", v => show_help = v != null },
                { "dry", "dry run, no scripts executed", m => dry = true },
                { "t|type=", "required: GTM or ISF", t => {
                    try { 
                        type = (DBConnections.DBType)Enum.Parse(typeof(DBConnections.DBType), t,true); }
                    catch (Exception e) { type = null; }
                }},
                { "output", "output a partner list", o=> output = true }
            };

            optionSet.Parse(args);

            if (args.Length == 0)
                show_help = true;

            if (string.IsNullOrEmpty(version))
                show_help = true;

            if (!type.HasValue)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine("type is invalid");
                Console.ForegroundColor = ConsoleColor.White;
                show_help = true;
            }

            if (show_help)
            {
                optionSet.WriteOptionDescriptions(System.Console.Out);
                return -1;
            }

            if (!output)
            {
                Console.WriteLine($"Using new folder structure: {!oldMode}");
                Console.WriteLine("");
            }

            if (string.IsNullOrEmpty(partnerID) && !allPartners && !noPartners)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine("must specify allPartners, noPartners or a partnerID");
                Console.ForegroundColor = ConsoleColor.White;
                optionSet.WriteOptionDescriptions(System.Console.Out);
                return -2;
            }

            //parse mapping
            Dictionary<string, string> mapping = new Dictionary<string, string>();
            string[] mapItems = map.Split(';');
            foreach (var m in mapItems)
            {
                string[] pair = m.Split('=');
                if (pair.Length == 2)
                {
                    mapping.Add(pair[0], pair[1]);
                }
            }

            var db = new DBConnections(type.Value, mapping);
            //Console.WriteLine(db.GetSecurityConnection());
            var directoryInfo = new System.IO.DirectoryInfo(version);
            if (oldMode)
            {
                if (!directoryInfo.Exists)
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("Directory does not exists: " + directoryInfo.FullName);
                    Console.ForegroundColor = ConsoleColor.White;
                    return -3;
                }
            }

            updatePartners = !String.IsNullOrEmpty(partnerID) || allPartners;
            if (noPartners && updatePartners)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine("can't specify a partnerID or allPartners and the noPartners flags together");
                Console.ForegroundColor = ConsoleColor.White;
                return -4;
            }

            if (type.Value == DBConnections.DBType.GTM)
            {
                if (!mapping.ContainsKey("Security") && updatePartners)
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("Security mapping must be provided");
                    Console.ForegroundColor = ConsoleColor.White;
                    return -5;
                }

                //get security connection
                string securityConnectionString = "";
                if (mapping.ContainsKey("Security") || updatePartners )
                {
                    securityConnectionString = db.GetSecurityConnection();
                    if (String.IsNullOrEmpty(securityConnectionString))
                    {
                        Console.ForegroundColor = ConsoleColor.Red;
                        Console.WriteLine("Security connection string can't be found");
                        Console.ForegroundColor = ConsoleColor.White;
                        return -6;
                    }
                }
            }

            if (output)
            {
                var cn = hidePassword(db.GetSecurityConnection());
                Console.WriteLine("Security Connection: " + cn);
                if (!string.IsNullOrEmpty(partnerID))
                {
                    Console.WriteLine("Partners: " + partnerID);
                }
                if (allPartners)
                {
                    List<DBConnections.PartnerConnections> partners = db.GetAllUniquePartnerConnectionStrings();
                    string result = "Partners: " + String.Join(",", partners.Select(p => p.PartnerID));
                    Console.WriteLine(result);
                }
                return 0;
            }

            if (updatePartners && !string.IsNullOrEmpty(partnerID))
            {
                connectionString = db.GetPartnerConnectionString(int.Parse(partnerID));
                if (String.IsNullOrEmpty(connectionString))
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.Error.WriteLine("partnerID not found in securityDB: " + partnerID);
                    Console.ForegroundColor = ConsoleColor.White;
                    return -7;
                }
            }

            //System.Diagnostics.Debugger.Launch();

            bool anyFailed = false;
            if (oldMode)
            {
                //directoryInfo == version folder
                foreach (var dir in GetDirectories(directoryInfo))
                {
                    Console.WriteLine("--------------------------------------------------------");
                    Console.WriteLine("-------------------" + dir.Name + "----------------------");
                    foreach (var item in System.IO.Directory.GetDirectories(dir.DirectoryInfo.FullName))
                    {
                        Console.WriteLine("--------------------------------------------------------");
                        System.IO.DirectoryInfo di = new System.IO.DirectoryInfo(item);
                        string name = di.Name;
                        if (!"Application".Equals(name))
                        {
                            handleNonApplicationMapping(dry, skipSecurityDB, mapping, db, ref anyFailed, di, name);
                        }
                        else if (updatePartners)
                        {
                            handlePartnerUpdates(dry, db, ref anyFailed, di, partnerID, allPartners);
                        }
                    }
                }
            }
            else
            {
                //directories in current folder will be Application, Biblioteca, etc
                //subdirectories will be version numbers
                directoryInfo = new DirectoryInfo(".");
                foreach (var dbfolder in Directory.GetDirectories(directoryInfo.FullName))
                {
                    DirectoryInfo di = new DirectoryInfo(dbfolder);
                    string name = di.Name;
                    di = new DirectoryInfo(Path.Combine(dbfolder, version));
                    if (di.Exists)
                    {
                        foreach (var dir in GetDirectories(di))
                        {
                            Console.WriteLine("--------------------------------------------------------");
                            Console.WriteLine("-------------------" + dir.Name + "----------------------");
                            Console.WriteLine("--------------------------------------------------------");
                            if (!"Application".Equals(name))
                            {
                                handleNonApplicationMapping(dry, skipSecurityDB, mapping, db, ref anyFailed, dir.DirectoryInfo, name);
                            }
                            else if (updatePartners)
                            {
                                handlePartnerUpdates(dry, db, ref anyFailed, dir.DirectoryInfo, partnerID, allPartners);
                            }
                        }
                    }
                }
            }

            Console.ForegroundColor = ConsoleColor.White;

            if (anyFailed)
                return -8;

            return 0;
        }

        private static void handleNonApplicationMapping(bool dry, bool skipSecurityDB, Dictionary<string, string> mapping, DBConnections db, ref bool anyFailed, DirectoryInfo di, string name)
        {
            string mapValue;
            if (mapping.TryGetValue(name, out mapValue))
            {
                Console.WriteLine(String.Format("Mapping for folder: {0} => {1}", name, mapValue));
                if ("Security".Equals(name) && skipSecurityDB)
                {
                    Console.WriteLine("skipping Security DB");
                }
                else
                {
                    var connectionString = BuildConnectionString(mapValue);
                    if ("Security".Equals(name))
                        connectionString = db.GetSecurityConnection();
                    Console.WriteLine(String.Format("Updating {0}@({1})", name, hideDetails(connectionString)));
                    var failed = performUpgrade(connectionString, di.FullName, dry);
                    if (failed)
                        anyFailed = true;
                }
            }
            else
            {
                Console.WriteLine("No mapping for folder: " + name);
            }
        }

        private static void handlePartnerUpdates(bool dry, DBConnections db, 
            ref bool anyFailed, DirectoryInfo di, string partnerID, bool allPartners)
        {
            string connectionString;
            if (!string.IsNullOrEmpty(partnerID))
            {
                connectionString = db.GetPartnerConnectionString(int.Parse(partnerID));

                //upgrade
                Console.WriteLine(String.Format("Updating partnerID: {0}@({1})", partnerID, hideDetails(connectionString)));
                var failed = performUpgrade(connectionString, di.FullName, dry);
                if (failed)
                    anyFailed = true;

            }
            if (allPartners)
            {
                List<DBConnections.PartnerConnections> partners = db.GetAllUniquePartnerConnectionStrings();

                foreach (var p in partners)
                {
                    //upgrade
                    connectionString = p.ConnectionString;
                    Console.WriteLine(String.Format("Updating partnerID: {0}@({1})", p.PartnerID, hideDetails(connectionString)));

                    var failed = performUpgrade(connectionString, di.FullName, dry);
                    if (failed)
                        anyFailed = true;
                }
            }
        }

        private static List<DirectoryData> GetDirectories(System.IO.DirectoryInfo directoryInfo)
        {
            List<DirectoryData> result = new List<DirectoryData>();

            Version v = new Version(directoryInfo.Name);
            Version v1 = MinusOne(v);
            Version v2 = MinusOne(v1);

            var directoryInfo1 = new System.IO.DirectoryInfo(System.IO.Path.Combine(directoryInfo.Parent.FullName, v1.ToString(), "Hotfix"));
            var directoryInfo2 = new System.IO.DirectoryInfo(System.IO.Path.Combine(directoryInfo.Parent.FullName, v2.ToString(), "Hotfix"));
            var directoryInfoMain = new System.IO.DirectoryInfo(System.IO.Path.Combine(directoryInfo.FullName, "Release"));
            var diCurrentReleaseHF = new System.IO.DirectoryInfo(System.IO.Path.Combine(directoryInfo.FullName, "Hotfix"));

            if (directoryInfo2.Exists)
                result.Add(new DirectoryData() { Name = v2.ToString() + "\\Hotfix", DirectoryInfo = directoryInfo2 });
            else //there is no separate Hotfix folder, check all scripts for release
            {
                directoryInfo2 = new System.IO.DirectoryInfo(System.IO.Path.Combine(directoryInfo.Parent.FullName, v2.ToString()));
                if (directoryInfo2.Exists)
                    result.Add(new DirectoryData() { Name = directoryInfo2.Name, DirectoryInfo = directoryInfo2 });
            }
            if (directoryInfo1.Exists)
                result.Add(new DirectoryData() { Name = v1.ToString() + "\\Hotfix", DirectoryInfo = directoryInfo1 });
            else //there is no separate Hotfix folder, check all scripts for release
            {
                directoryInfo1 = new System.IO.DirectoryInfo(System.IO.Path.Combine(directoryInfo.Parent.FullName, v1.ToString()));
                if (directoryInfo1.Exists)
                    result.Add(new DirectoryData() { Name = directoryInfo1.Name, DirectoryInfo = directoryInfo1 });
            }

            if (directoryInfoMain.Exists)
                result.Add(new DirectoryData() { Name = directoryInfo.Name + "\\Release", DirectoryInfo = directoryInfoMain });
            else
                result.Add(new DirectoryData() { Name = directoryInfo.Name, DirectoryInfo = directoryInfo });

            if (diCurrentReleaseHF.Exists)
                result.Add(new DirectoryData() { Name = directoryInfo.Name + "\\Hotfix", DirectoryInfo = diCurrentReleaseHF });

            return result;
        }

        private static Version MinusOne(Version v)
        {
            if (v.Minor == 1)
                return new Version(v.Major - 1, 4);
            return new Version(v.Major, v.Minor - 1);
        }

        private static string BuildConnectionString(string mapping)
        {
            string name = mapping;
            string type = "userauth";
            if(mapping.Contains(":"))
            {
                name = mapping.Split(':')[0];
                type = mapping.Split(':')[1];
            }
            string cn = IntegrationPoint.Sql.Utility.GetDBConnectionString(name, type);
            return cn;
        }

        private static bool performUpgrade(string connectionString, string directory, bool dry)
        {
            DbUp.Engine.DatabaseUpgradeResult result = null;
            bool failed = false;

            var sqlConnectionManager = new SqlConnectionManager(connectionString);
            var log = new ConsoleUpgradeLog();
            var journal = new FlywayLikeJournal(() => sqlConnectionManager, () => log, null, FlywayLikeExtensions.VersionTableName);

            DbUp.Builder.UpgradeConfiguration config = null;
            var dbupBuilder = DeployChanges.To
                .HashedSqlDatabase(sqlConnectionManager)
                .WithExecutionTimeout(TimeSpan.FromSeconds(30 * 60))
                .WithTransactionPerScript()
                .WithHashedScriptsInDirectory(directory, journal)
                .LogToConsole().LogScriptOutput();
            
            dbupBuilder.Configure(c => config = c);
            var dbup = dbupBuilder.Build();
            var IPEngine = new IPUpgradeEngine(config);
            
            if (dry)
            {
                foreach (var item in IPEngine.GetScriptsToExecute())
                {
                    Console.WriteLine("\tDry run: " + item.Name);
                }
            }
            else
            {
                result = IPEngine.PerformUpgrade();
            }


            if (dry || result.Successful)
            {
                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine("Success!\n");
            }
            else
            {
                failed = true;
                if (!dry)
                {
                    MultipleScriptException ex = result.Error as MultipleScriptException;
                    if (ex != null)
                    {
                        Console.WriteLine("Scripts that failed: ");
                        foreach (var item in ex.FailedScripts)
                        {
                            Console.ForegroundColor = ConsoleColor.White;
                            Console.Error.Write("\t" + item.script.Name);
                            Console.ForegroundColor = ConsoleColor.Red;
                            Console.Error.WriteLine(String.Format(" == Error: {0}", item.error.Message.Replace("\n", "\n\t\t")));
                        }
                    }
                    else
                    {
                Console.ForegroundColor = ConsoleColor.Red;
                    Console.Error.WriteLine(result.Error);
                    }
                }
                Console.WriteLine("Failed!\n");
            }
            Console.ForegroundColor = ConsoleColor.White;

            return failed;
        }

        private static string hideDetails(string s)
        {
            return hideUser(hidePassword(s));
        }

        private static string hidePassword(string s)
        {
            string result = s;
            int index = s.IndexOf("password=", 0, StringComparison.InvariantCultureIgnoreCase);
            if (index >= 0)
            {
                int index2 = s.IndexOf(";", index, StringComparison.InvariantCultureIgnoreCase);
                if (index2 >= 0)
                {
                    result = result.Substring(0, index + 9) + result.Substring(index2);
                }
                else
                {
                    result = result.Substring(0, index + 9);
                }
            }
            return result;
        }

        private static string hideUser(string s)
        {
            string result = s;
            int index = s.IndexOf("user id=", 0, StringComparison.InvariantCultureIgnoreCase);
            if (index >= 0)
            {
                int index2 = s.IndexOf(";", index, StringComparison.InvariantCultureIgnoreCase);
                if (index2 >= 0)
                {
                    result = result.Substring(0, index + 8) + result.Substring(index2);
                }
                else
                {
                    result = result.Substring(0, index + 8);
                }
            }
            return result;
        }

        private static bool newMethod(DirectoryInfo rootpath)
        {
            return Directory.Exists(Path.Combine(rootpath.FullName, "Application"));
        }
    }

    class DirectoryData
    {
        public string Name { get; set; }
        public System.IO.DirectoryInfo DirectoryInfo { get; set; }
    }
}
