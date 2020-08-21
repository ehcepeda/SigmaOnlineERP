using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FastReport.Web;

namespace SigmaOnlineERP
{
    public partial class accounts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                refresh();
            }
        }

        protected void refresh()
        {
            DataSetAccountingTableAdapters.list_company_accountsTableAdapter taaccounts = new DataSetAccountingTableAdapters.list_company_accountsTableAdapter();
            var qaccounts = taaccounts.GetData(Convert.ToInt32(Session["companyid"])).AsEnumerable().
                Where(row => row.Field<String>("name").ToUpper().Contains(tbsearch.Text.Trim().ToUpper())
                || row.Field<String>("accountid").ToUpper().Contains(tbsearch.Text.Trim().ToUpper())).ToList();

            //DataTable dtaccounts = taaccounts.GetData(Convert.ToInt32(Session["companyid"]));
            gvaccounts.DataSource = qaccounts;
            gvaccounts.DataBind();

            if (qaccounts.Count == 0)
            {
                DataTable myCompany = new DataTable();
                myCompany.Columns.AddRange(new DataColumn[9]
                    {
                        new DataColumn("accountid", typeof(string)),
                        new DataColumn("name", typeof(string)),
                        new DataColumn("account_type", typeof(string)),
                        new DataColumn("origin", typeof(string)),
                        new DataColumn("controlid", typeof(string)),
                        new DataColumn("isdetail", typeof(Int32)),
                        new DataColumn("direct", typeof(Int32)),
                        new DataColumn("isenabled", typeof(Int32)),
                        new DataColumn("create_date", typeof(DateTime))
                    });

                DataRow drItem = myCompany.NewRow();
                drItem["name"] = "";
                myCompany.Rows.Add(drItem);
                gvaccounts.DataSource = myCompany;
                gvaccounts.DataBind();
            }
        }

        protected void gvaccounts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvaccounts.PageIndex = e.NewPageIndex;
            gvaccounts.SelectedIndex = -1;
            refresh();
        }

        protected void gvaccounts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {
                string accountid = e.CommandArgument.ToString();

                DataSetAccountingTableAdapters.company_accountsTableAdapter taaccounts = new DataSetAccountingTableAdapters.company_accountsTableAdapter();
                DataTable dtaccounts = taaccounts.GetDataBy_Account(Convert.ToInt32(Session["companyid"]), accountid);
                if (dtaccounts.Rows.Count > 0)
                {
                    Response.Redirect("newaccount.aspx?c=" + dtaccounts.Rows[0]["hashid"].ToString() + "&ix=" + gvaccounts.PageIndex.ToString());
                }
            }
            else if (e.CommandName == "inactivate")
            {
                string accountid = e.CommandArgument.ToString();

                DataSetAccountingTableAdapters.company_accountsTableAdapter taaccounts = new DataSetAccountingTableAdapters.company_accountsTableAdapter();
                taaccounts.UpdateStatus(0, Convert.ToInt32(Session["companyid"]), accountid);

                refresh();

                util utilclass = new util();
                utilclass.messageinfo(this, "Satisfactorio!", "Se ha Inactivado esta Cuenta!", "success", "");
            }
            else if (e.CommandName == "reactivate")
            {
                string accountid = e.CommandArgument.ToString();

                DataSetAccountingTableAdapters.company_accountsTableAdapter taaccounts = new DataSetAccountingTableAdapters.company_accountsTableAdapter();
                taaccounts.UpdateStatus(1, Convert.ToInt32(Session["companyid"]), accountid);

                refresh();

                util utilclass = new util();
                utilclass.messageinfo(this, "Satisfactorio!", "Se ha Activado esta Cuenta nuevamente!", "success", "");
            }
            else if (e.CommandName == "erase")
            {
                util utilclass = new util();
                string accountid = e.CommandArgument.ToString();

                DataSetAccountingTableAdapters.company_accountsTableAdapter taaccounts = new DataSetAccountingTableAdapters.company_accountsTableAdapter();
                DataTable dtaccounts = taaccounts.GetDataBy_Control(Convert.ToInt32(Session["companyid"]), accountid);
                if (dtaccounts.Rows.Count > 0)
                {
                    utilclass.messageinfo(this, "Error!", "Esta cuenta es control de otras cuentas.!", "error", "");
                }
                else
                {
                    taaccounts.DeleteAccount(Convert.ToInt32(Session["companyid"]), accountid);
                    refresh();
                    utilclass.messageinfo(this, "Satisfactorio!", "Se ha Eliminado la Cuenta " + accountid + "!", "success", "");
                }
            }
        }

        protected void btn_add_Click(object sender, EventArgs e)
        {
            Response.Redirect("newaccount.aspx?ix=" + gvaccounts.PageIndex.ToString());
        }

        protected void gvaccounts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label isdetail = (Label)e.Row.FindControl("lbisdetail");
                if (isdetail.Text.Trim() == "No")
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#F8F9F9");
                    e.Row.Font.Bold = true;
                }
            }
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            refresh();
        }

        protected void btn_export_Click(object sender, EventArgs e)
        {

            string _abre = "<script>window.open('http://localhost:81/api/reports/1?format=pdf&inline=true&vcompanyid=" + Session["companyid_hash"] +
                "&vuser=" + Session["userid_hash"] + "','','scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=1100, height=800,left=200,top=100');</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", _abre);
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
               server control at run time. */
        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {
            refresh();
        }
    }
}
