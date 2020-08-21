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
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                userpassword.Text = "";
                username.Text = "  ";
            }
        }

        protected void btnok_Click(object sender, EventArgs e)
        {
            Session.Clear();
            DataSetSecurityTableAdapters.usersTableAdapter tausers = new DataSetSecurityTableAdapters.usersTableAdapter();
            DataTable dtusers = tausers.GetDataBy_username(username.Text.Trim());
            util utilclass = new util();
            if (dtusers.Rows.Count == 0)
            {
                utilclass.messageinfo(this, "Error!", "Este usuario no existe o la contraseña no es correcta!", "error", "");
            }
            else if (dtusers.Rows[0]["passwordhash"].ToString() != FormsAuthentication.HashPasswordForStoringInConfigFile(userpassword.Text, "SHA1"))
            {
                utilclass.messageinfo(this, "Error!", "La contraseña no es correcta", "error", "");
            }
            else
            {
                Session["userid"] = dtusers.Rows[0]["userid"].ToString();
                Session["username"] = dtusers.Rows[0]["username"].ToString();
                Session["name"] = dtusers.Rows[0]["name"].ToString();
                Session["image_name"] = dtusers.Rows[0]["image_name"].ToString();
                Session["userid_hash"] = dtusers.Rows[0]["hashid"].ToString();

                DataSetSecurityTableAdapters.companyTableAdapter tacompany = new DataSetSecurityTableAdapters.companyTableAdapter();
                DataTable dtcompany = tacompany.GetDataBy_ID(1);
                if (dtcompany.Rows.Count > 0)
                {
                    Session["image_logo"] = dtcompany.Rows[0]["image_logo"].ToString();
                    Session["image_stamp"] = dtcompany.Rows[0]["image_stamp"].ToString();
                    Session["companyid"] = dtcompany.Rows[0]["companyid"].ToString();
                    Session["companyid_hash"] = dtcompany.Rows[0]["hashid"].ToString();
                }
                else
                {
                    Session["image_logo"] = "yourlogo.jpg";
                    Session["image_stamp"] = "yourstamp.jpg";
                }

                Response.Redirect("default.aspx");
            }
        }
    }
}