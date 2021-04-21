using DbUp.Builder;
using DbUp.Engine;
using DbUp.Support.SqlServer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBUpgrade
{    
    public static class FlywayLikeExtensions
    {
        public const string VersionTableName = "ReleaseSqlChecksums";

        public static UpgradeEngineBuilder HashedSqlDatabase(this SupportedDatabases supported, SqlConnectionManager connectionManager)
        {
            var builder = new UpgradeEngineBuilder();
            builder.Configure(c => c.ConnectionManager = connectionManager);
            builder.Configure(c => c.ScriptExecutor = new SqlScriptExecutor(() => c.ConnectionManager, () => c.Log, null, () => c.VariablesEnabled, c.ScriptPreprocessors));
            builder.Configure(c => c.Journal = new FlywayLikeJournal(() => c.ConnectionManager, () => c.Log, null, VersionTableName));
            return builder;
        }

        /// <summary>
        /// Adds all scripts found as embedded resources in the given assembly.
        /// </summary>
        /// <param name="builder">The builder.</param>
        /// <param name="assembly">The assembly.</param>
        /// <param name="filter">The filter.</param>
        /// <param name="journal">The journal.</param>
        /// <returns>
        /// The same builder
        /// </returns>
        public static UpgradeEngineBuilder WithHashedScriptsInDirectory(this UpgradeEngineBuilder builder, String directory, IJournal journal)
        {
            return WithScripts(builder, new ReadOnlyScriptProvider(directory, journal));
        }

        /// <summary>
        /// Adds a custom script provider to the upgrader.
        /// </summary>
        /// <param name="builder">The builder.</param>
        /// <param name="scriptProvider">The script provider.</param>
        /// <returns>
        /// The same builder
        /// </returns>
        public static UpgradeEngineBuilder WithScripts(this UpgradeEngineBuilder builder, IScriptProvider scriptProvider)
        {
            builder.Configure(c => c.ScriptProviders.Add(scriptProvider));
            return builder;
        }
    }
}
