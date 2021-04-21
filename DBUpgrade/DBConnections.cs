using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBUpgrade
{

    public class DBConnections
    {
        public enum DBType
        {
            GTM,
            ISF
        }

        private DBType dbType;
        private Dictionary<string, string> mapping = new Dictionary<string, string>();

        public DBConnections(DBType type, Dictionary<string, string> mapping)
        {
            dbType = type;
            this.mapping = mapping;
        }

        public string GetSecurityConnection()
        {
            string cn = null;
            switch (dbType)
            {
                case DBType.GTM:
                    cn = BuildConnectionString(mapping["Security"]);
                    break;
                case DBType.ISF:
                    cn = IntegrationPoint.Core.Sql.Security.SqlConnectionString();
                    break;
            }
            return cn;
        }

        public string GetPartnerConnectionString(int partnerID)
        {
            string cn = null;
            switch (dbType)
            {
                case DBType.GTM:
                    var secDB = GetSecurityConnection();
                    cn = IntegrationPoint.Sql.Utility.GetPartnerDataConnectionString("" + partnerID, "", secDB);
                    break;
                case DBType.ISF:
                    cn = IntegrationPoint.Core.Sql.Partner.SqlConnectionString(partnerID);
                    break;
            }
            return cn;
        }

        public List<PartnerConnections> GetAllUniquePartnerConnectionStrings()
        {
            List<PartnerConnections> result = new List<PartnerConnections>();
            switch (dbType)
            {
                case DBType.GTM:
                    var secDB = GetSecurityConnection();
                    List<int> partners = new List<int>();
                    using (var sqlConnection = IntegrationPoint.Sql.Utility.GetSqlConnection(secDB))
                    {
                        sqlConnection.Open();
                        using (var sqlCommand = sqlConnection.CreateCommand())
                        {
                            sqlCommand.CommandText = "select partnerID from tmgPartnerDataConnection";
                            using (var sqlReader = sqlCommand.ExecuteReader())
                            {
                                while (sqlReader.Read())
                                {
                                    partners.Add(sqlReader.GetInt32(0));
                                }
                            }
                        }
                    }

                    Dictionary<string, string> connections = new Dictionary<string, string>();
                    foreach (var p in partners)
                    {
                        //upgrade
                        var connectionString = IntegrationPoint.Sql.Utility.GetPartnerDataConnectionString("" + p, "", secDB);
                        if (connectionString != null && !connections.ContainsKey(connectionString.ToLower()))
                        {
                            connections.Add(connectionString.ToLower(), String.Empty);
                            result.Add(new PartnerConnections() { PartnerID = p, ConnectionString = connectionString });
                        }
                    }
                    break;
                case DBType.ISF:
                    var isfPartnerConnections = IntegrationPoint.Core.Sql.Security.PartnerConnectionStringsAsDictionary();

                    var isfPartners = IntegrationPoint.Core.Sql.Security.PartnerIdList();
                    Dictionary<string, string> isfConnections = new Dictionary<string, string>();
                    foreach (int p in isfPartners)
                    {
                        //upgrade
                        var connectionString = "";
                        if (isfPartnerConnections.ContainsKey(p))
                            connectionString = isfPartnerConnections[p];
                        else
                            connectionString = IntegrationPoint.Core.Sql.Partner.SqlConnectionString(p);
                        if (!isfConnections.ContainsKey(connectionString.ToLower()))
                        {
                            isfConnections.Add(connectionString.ToLower(), String.Empty);
                            result.Add(new PartnerConnections() { PartnerID = p, ConnectionString = connectionString });
                        }
                    }
                    break;
            }
            return result;
        }

        public static string BuildConnectionString(string mapping)
        {
            string name = mapping;
            string type = "userauth";
            if (mapping.Contains(":"))
            {
                name = mapping.Split(':')[0];
                type = mapping.Split(':')[1];
            }
            string cn = IntegrationPoint.Sql.Utility.GetDBConnectionString(name, type);
            return cn;
        }

        public class PartnerConnections
        {
            public int PartnerID { get; set; }
            public string ConnectionString { get; set; }
        }
    }
}
