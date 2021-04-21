using DbUp.Engine;
using DbUp.Engine.Transactions;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBUpgrade
{
    public class WriteOnlyJournal : IJournal
    {
        private Func<IConnectionManager> connectionManager;

        public WriteOnlyJournal(Func<IConnectionManager> connectionManager)
        {
            this.connectionManager = connectionManager;
        }

        public string[] GetExecutedScripts()
        {
            return new string[0];
        }

        public void StoreExecutedScript(SqlScript script)
        {
            connectionManager().ExecuteCommandsWithManagedConnection(dbCommandFactory =>
                {
                    using(var command = dbCommandFactory())
                    {
                        command.CommandText = @"IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE ID = OBJECT_ID(N'[dbo].[ReleaseSqlApplied]') AND OBJECTPROPERTY(ID, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[ReleaseSqlApplied](
	[AppliedDate] [datetime] NOT NULL,
	[Filename] [nvarchar](255) NOT NULL
) ON [PRIMARY]
END
insert into dbo.ReleaseSqlApplied(AppliedDate, [Filename]) values (GETDATE(), @name) ";
                        var param = command.CreateParameter();
                        param.ParameterName = "@name";
                        param.Value = script.Name;
                        param.DbType = DbType.String;
                        command.Parameters.Add(param);

                        command.CommandType = CommandType.Text;
                        command.ExecuteNonQuery();
                    }
                });

        }
    }
}
