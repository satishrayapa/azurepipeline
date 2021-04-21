using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

using DbUp.Engine;
using DbUp.Engine.Transactions;

namespace DBUpgrade
{
    class ReadOnlyScriptProvider : IScriptProvider
    {
        private readonly string directoryPath;
        private readonly FlywayLikeJournal _journal;

        ///<summary>
        ///</summary>
        ///<param name="directoryPath">Path to SQL upgrade scripts</param>
        public ReadOnlyScriptProvider(string directoryPath,
            IJournal journal)
        {
            this.directoryPath = directoryPath;
            this._journal = (FlywayLikeJournal)journal;
        }

        /// <summary>
        /// Gets all scripts that should be executed.
        /// </summary>
        public IEnumerable<SqlScript> GetScripts(IConnectionManager connectionManager)
        {
            var executedScriptInfo = _journal.GetExecutedScriptDictionary();

            var allScripts = Directory.GetFiles(directoryPath, "*.sql").Select<string, ReadOnlyScript>(ReadOnlyScript.FromFile).ToList();

            var l = allScripts
                .Where(script =>
                !executedScriptInfo.ContainsKey(script.Name)
                    || (!script.Name.ToUpper().StartsWith("V") && executedScriptInfo.ContainsKey(script.Name) && executedScriptInfo[script.Name] != Md5Utils.Md5EncodeString(script.Contents)));

            var ord = ReadOnlyScript.Order(l);
            return ord;
        }
    }
}
