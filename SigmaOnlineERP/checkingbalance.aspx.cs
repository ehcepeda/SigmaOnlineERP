using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaOnlineERP
{
    public partial class checkingbalance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else if (!IsPostBack)
            {
                cbyear.SelectedValue = DateTime.Now.Year.ToString();
                refresh();
            }
        }

        protected void Page_PreInit(object sender, EventArgs e)
        {
            System.Web.UI.HtmlControls.HtmlGenericControl option_main = (System.Web.UI.HtmlControls.HtmlGenericControl)Master.FindControl("maccounting");
            option_main.Attributes.Add("class", "active mm-active");

            HyperLink option_menu = (HyperLink)Master.FindControl("maccounting_checking_balance");
            option_menu.Attributes.Add("class", "active");
        }

        protected void refresh()
        {
            string strConnString = ConfigurationManager.ConnectionStrings["ConnectionStringSigma"].ConnectionString;
            OleDbConnection conn = new OleDbConnection(strConnString);
            OleDbCommand cmd = new OleDbCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "pr_checking_balance";
            cmd.Parameters.AddWithValue("@companyid", Convert.ToInt32(Session["companyid"]));
            cmd.Parameters.AddWithValue("@ano", Convert.ToInt32(cbyear.SelectedValue));
            cmd.Connection = conn;
            conn.Open();
            OleDbDataReader dr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(dr);
            gvbalance.DataSource = dt;
            gvbalance.DataBind();
        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {
            refresh();
        }

        protected void btn_export_Click(object sender, EventArgs e)
        {

        }

        protected void gvbalance_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label isdetail = (Label)e.Row.FindControl("lbisdetail");
                if (isdetail.Text.Trim() == "0")
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#F8F9F9");
                    e.Row.Font.Bold = true;
                }

                if (e.Row.Cells[1].Text == "9999999999")
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#EAFAF1");
                    e.Row.Font.Bold = true;
                    e.Row.Cells[1].Text = "";
                }
            }
        }
    }
}