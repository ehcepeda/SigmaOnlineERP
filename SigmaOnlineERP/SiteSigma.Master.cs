using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaOnlineERP
{
    public partial class SiteSigma : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else if (!IsPostBack)
            {
                //colocando nombre del usuario
                DataSetSecurityTableAdapters.usersTableAdapter tausers = new DataSetSecurityTableAdapters.usersTableAdapter();
                DataTable dtusers = tausers.GetDataBy_ID(Convert.ToInt32(Session["userid"]));
                if (dtusers.Rows.Count > 0)
                {
                    lbsite_username.Text = Session["username"].ToString();
                    img_site_username.Src = "./assets/images/users/" + Session["image_name"].ToString();

                    img_logo_sm.Src = "./assets/images/logos/" + Session["image_logo"].ToString();
                    img_logo_lg.Src = "./assets/images/logos/" + Session["image_logo"].ToString();
                }
                else
                {
                    Session.Abandon();
                    Response.Redirect("Login.aspx");
                }
            }
        }
    }
}