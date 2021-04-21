using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DBUpgrade
{
    public class DevNullJournal : DbUp.Engine.IJournal
    {
        #region IJournal Members

        public string[] GetExecutedScripts()
        {
            return new string[0];
        }

        public void StoreExecutedScript(DbUp.Engine.SqlScript script)
        {
            
        }

        #endregion
    }
}
