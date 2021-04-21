using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

//using DbUp;
using System.Diagnostics;
using System.Data.SqlClient;
using System.Collections.Generic;
using DbUp;
using DBUpgrade;
using DbUp.Support.SqlServer;
using DbUp.Engine.Output;

namespace DBUpgradeTest
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestSecurityUpgrade()
        {
            string directory; //= @"D:\Dev\projects\Main\GTM\Database\" + GetVersion() + @"\Security";
            directory = System.IO.Path.Combine(GetDatabaseScriptPath(), GetVersion());
            var dir = new System.IO.DirectoryInfo(directory);
            var directories = GetDirectories(dir, "Security");
            string sourceDB = "jg_sec";
            if (directories.Count > 0)
            {
                sourceDB = System.Configuration.ConfigurationManager.AppSettings["securityCatalog"];
                string testDB = sourceDB + "_test";

                string server = System.Configuration.ConfigurationManager.AppSettings["dbServer"];
                string connectionString = @"server=" + server + ";database=" + testDB + ";user ID=" + GetUserid() + ";Password=" + GetDatabasePassword();

                using (var x = new TestDBDisposable(sourceDB, testDB, connectionString))
                {
                    foreach (var folder in directories)
                    {
                        Console.WriteLine("scripts for location: " + folder.DirectoryInfo.FullName);

                        DbUp.Engine.DatabaseUpgradeResult result = null;

                        var sqlConnectionManager = new SqlConnectionManager(connectionString);
                        var log = new ConsoleUpgradeLog();
                        var journal = new FlywayLikeJournal(() => sqlConnectionManager, () => log, null, FlywayLikeExtensions.VersionTableName);

                        var dbupBuilder = DeployChanges.To
                            .HashedSqlDatabase(sqlConnectionManager)
                            .WithExecutionTimeout(TimeSpan.FromSeconds(30 * 60))
                            .WithTransactionPerScript()
                            .WithHashedScriptsInDirectory(folder.DirectoryInfo.FullName, journal)
                            .LogToConsole().LogScriptOutput();
                        var dbup = dbupBuilder.Build();
                        result = dbup.PerformUpgrade();

                        string msg = "";
                        if (result.Error != null)
                            msg = result.Error.ToString();
                        Assert.IsTrue(result.Successful, msg);


                        //deploy a second time to ensure scripts check for existence before adding
                        result = null;
                        dbupBuilder = DeployChanges.To
                            .HashedSqlDatabase(sqlConnectionManager)
                            .WithExecutionTimeout(TimeSpan.FromSeconds(30 * 60))
                            .WithTransactionPerScript()
                            .WithHashedScriptsInDirectory(folder.DirectoryInfo.FullName, journal)
                            .LogToConsole().LogScriptOutput();
                        dbup = dbupBuilder.Build();
                        result = dbup.PerformUpgrade();

                        msg = "";
                        if (result.Error != null)
                            msg = "Second run: " + result.Error.ToString();
                        Assert.IsTrue(result.Successful, msg);
                    }
                }
            }
            else
            {
                Console.WriteLine("Directory not found: " + directory);
                Assert.IsTrue(true, "directory doesn't exist, nothing to test");
            }
        }

        [TestMethod]
        public void TestApplicationUpgrade()
        {
            string directory; //= @"D:\Dev\projects\Main\GTM\Database\" + GetVersion() + @"\Application";
            directory = System.IO.Path.Combine(GetDatabaseScriptPath(), GetVersion());
            var dir = new System.IO.DirectoryInfo(directory);
            var directories = GetDirectories(dir, "Application");
            string sourceDB = "jg_demo2";
            if (directories.Count > 0)
            {
                sourceDB = System.Configuration.ConfigurationManager.AppSettings["applicationCatalog"];
                string testDB = sourceDB + "_test";

                string server = System.Configuration.ConfigurationManager.AppSettings["dbServer"];
                string connectionString = @"server=" + server + ";database=" + testDB + ";user ID=" + GetUserid() + ";Password=" + GetDatabasePassword();
                
                using (var x = new TestDBDisposable(sourceDB, testDB, connectionString))
                {
                    foreach (var folder in directories)
                    {
                        Console.WriteLine("scripts for location: " + folder.DirectoryInfo.FullName);

                        DbUp.Engine.DatabaseUpgradeResult result = null;
                        var sqlConnectionManager = new SqlConnectionManager(connectionString);
                        var log = new ConsoleUpgradeLog();
                        var journal = new FlywayLikeJournal(() => sqlConnectionManager, () => log, null, FlywayLikeExtensions.VersionTableName);

                        var dbupBuilder = DeployChanges.To
                            .HashedSqlDatabase(sqlConnectionManager)
                            .WithExecutionTimeout(TimeSpan.FromSeconds(30 * 60))
                            .WithTransactionPerScript()
                            .WithHashedScriptsInDirectory(folder.DirectoryInfo.FullName, journal)
                            .LogToConsole().LogScriptOutput();
                        var dbup = dbupBuilder.Build();
                        result = dbup.PerformUpgrade();

                        string msg = "";
                        if (result.Error != null)
                            msg = result.Error.ToString();
                        Assert.IsTrue(result.Successful, msg);


                        //deploy a second time to ensure scripts check for existence before adding
                        result = null;
                        dbupBuilder = DeployChanges.To
                            .HashedSqlDatabase(sqlConnectionManager)
                            .WithExecutionTimeout(TimeSpan.FromSeconds(30 * 60))
                            .WithTransactionPerScript()
                            .WithHashedScriptsInDirectory(folder.DirectoryInfo.FullName, journal)
                            .LogToConsole().LogScriptOutput();
                        dbup = dbupBuilder.Build();
                        result = dbup.PerformUpgrade();

                        msg = "";
                        if (result.Error != null)
                            msg = "Second run: " + result.Error.ToString();
                        Assert.IsTrue(result.Successful, msg);
                    }
                }
            }
            else
                Assert.IsTrue(true, "directory doesn't exist, nothing to test");
        }

        private string GetVersion()
        {
            var dev = this;
            var asm = System.Reflection.Assembly.GetAssembly(dev.GetType());
            string ver = FileVersionInfo.GetVersionInfo(asm.Location).FileVersion;
            int index = ver.IndexOf('.');
            index = ver.IndexOf('.', index+1);
            return ver.Substring(0, index);
        }

        private string GetDatabaseScriptPath()
        {
            var dev = this;
            var asm = System.Reflection.Assembly.GetAssembly(dev.GetType());
            Console.WriteLine("asmLocation: " + asm.Location);
            string upPath = @"..\..\..\..\Database";
            if(!asm.Location.StartsWith(@"d:\dev", StringComparison.InvariantCultureIgnoreCase))
                upPath = @"..\..\src\GTM\Database";
            string path = System.IO.Path.Combine(asm.Location, upPath);
            return System.IO.Path.GetFullPath(path);
        }   
     
        private string GetDatabasePassword()
        {
            var c = new dugUtilities.CConnectionInfo();
            c.ConnectionString("ftzweb", "userauth");
            var d = new dugEncryptDecrypt.IntegrationPoint.CEncryptDecrypt();
            return d.DecryptWithSeed(c.Password);
        }
        private string GetUserid()
        {
            var c = new dugUtilities.CConnectionInfo();
            c.ConnectionString("ftzweb", "userauth");
            var d = new dugEncryptDecrypt.IntegrationPoint.CEncryptDecrypt();
            return c.UserID;
        }

        private static List<DirectoryData> GetDirectories(System.IO.DirectoryInfo directoryInfo, String pathSuffix = "")
        {
            List<DirectoryData> result = new List<DirectoryData>();

            Version v = new Version(directoryInfo.Name);
            Version v1 = MinusOne(v);
            Version v2 = MinusOne(v1);

            var directoryInfo1 = new System.IO.DirectoryInfo(System.IO.Path.Combine(v1.ToString(), "Hotfix", pathSuffix));
            var directoryInfo2 = new System.IO.DirectoryInfo(System.IO.Path.Combine(v2.ToString(), "Hotfix", pathSuffix));
            var directoryInfoMain = new System.IO.DirectoryInfo(System.IO.Path.Combine(directoryInfo.FullName, "Release", pathSuffix));
            var diCurrentReleaseHF = new System.IO.DirectoryInfo(System.IO.Path.Combine(directoryInfo.FullName, "Hotfix", pathSuffix));
            var diCurrentBase = new System.IO.DirectoryInfo(System.IO.Path.Combine(directoryInfo.FullName, pathSuffix));

            if (directoryInfo2.Exists)
                result.Add(new DirectoryData() { Name = v2.ToString() + "\\Hotfix", DirectoryInfo = directoryInfo2 });
            if (directoryInfo1.Exists)
                result.Add(new DirectoryData() { Name = v1.ToString() + "\\Hotfix", DirectoryInfo = directoryInfo1 });

            if (directoryInfoMain.Exists)
                result.Add(new DirectoryData() { Name = directoryInfo.Name + "\\Release", DirectoryInfo = directoryInfoMain });
            else
            {
                if(diCurrentBase.Exists)
                    result.Add(new DirectoryData() { Name = directoryInfo.Name, DirectoryInfo = diCurrentBase });
            }

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
    }

    class DirectoryData
    {
        public string Name { get; set; }
        public System.IO.DirectoryInfo DirectoryInfo { get; set; }
    }

    class TestDBDisposable : IDisposable
    {
        private string fromDB;
        private string toDB;
        private string connectionString;

        public TestDBDisposable(string fromDB, string toDB, string connectionString)
        {
            this.fromDB = fromDB;
            this.toDB = toDB;
            this.connectionString = connectionString;
            createDatabase(fromDB, toDB, connectionString);
        }

        private void createDatabase(string fromDB, string toDB, string connectionString)
        {
            string cn = connectionString.Replace("database=" + toDB + ";", "database=" + fromDB + ";");
            string bakLocation = @"D:\SQL Backups\";
            string dataLocation = @"D:\SQL Server\MSSQL10_50.SQL2008\MSSQL\DATA\";
            string logLocation = @"L:\SQL Server\MSSQL10_50.SQL2008\MSSQL\Logs\";
            string logicalData = fromDB;
            string logicalLog = fromDB + "_log";
            bakLocation = System.Configuration.ConfigurationManager.AppSettings["backupLocation"];
            dataLocation = System.Configuration.ConfigurationManager.AppSettings["dataLocation"];
            logLocation = System.Configuration.ConfigurationManager.AppSettings["logLocation"];
            logicalData = System.Configuration.ConfigurationManager.AppSettings[fromDB + ":LogicalData"] ?? logicalData;
            logicalLog = System.Configuration.ConfigurationManager.AppSettings[fromDB + ":logicalLog"] ?? logicalLog;

            using (SqlConnection cnn = new SqlConnection(cn))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    try
                    {
                        cnn.Open();
                        cmd.Connection = cnn;
                        cmd.CommandTimeout = 1000;
                        cmd.CommandText = "backup database " + fromDB + @" to disk = '" + bakLocation + fromDB + @"\" + fromDB + ".BAK' with init";
                        cmd.ExecuteNonQuery();

                        cmd.CommandText = "restore database " + toDB + @" from disk= '" + bakLocation + fromDB + @"\" + fromDB + @".BAK' with 
                        move '" + logicalData + @"' to '" + dataLocation + toDB + @".mdf',
                        move '" + logicalLog + @"' to '" + logLocation + toDB + "_log.ldf', replace";
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                        throw;
                    }
                }
                cnn.Close();
            }
        }

        private void dropDatabase(string fromDB, string toDB, string connectionString)
        {
            string cn = connectionString.Replace("database=" + toDB + ";", "database=" + fromDB + ";");
            using (SqlConnection cnn = new SqlConnection(cn))
            {
                using (SqlCommand cmd = cnn.CreateCommand())
                {
                    try
                    {
                        SqlConnection.ClearAllPools();
                        cnn.Open();
                        cmd.Connection = cnn;
                        cmd.CommandTimeout = 1000;
                        cmd.CommandText = "drop database " + toDB;

                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                        throw;
                    }
                }
                cnn.Close();
            }
        }

        public void Dispose()
        {
            dropDatabase(fromDB, toDB, connectionString);
        }
    }
}
