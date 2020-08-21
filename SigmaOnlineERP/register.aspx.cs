using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaOnlineERP
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnok_Click(object sender, EventArgs e)
        {
            DataSetSecurityTableAdapters.usersTableAdapter tausers = new DataSetSecurityTableAdapters.usersTableAdapter();
            DataTable dtusers = tausers.GetDataBy_Email(useremail.Text.Trim());
            util utilclass = new util();
            if (dtusers.Rows.Count > 0)
            {
                utilclass.messageinfo(this, "Error!", "Ya existe un usuario registrado con este correo!", "error", "");
            }
            else
            {
                dtusers = tausers.GetDataBy_username(username.Text.Trim());
                if (dtusers.Rows.Count > 0)
                {
                    utilclass.messageinfo(this, "Error!", "Ya existe un usuario registrado con este nombre!", "error", "");
                }
                else
                {
                    Session.Clear();
                    tausers.InsertUser(useremail.Text.Trim(), FormsAuthentication.HashPasswordForStoringInConfigFile(userpassword.Text.Trim(), "SHA1"),
                        username.Text.Trim(), 1);
                    utilclass.messageinfo(this, "Felicitaciones!", "Has creado tu usuario satisfactoriamente!", "success", "login.aspx");
                }
            }
        }
    }
}