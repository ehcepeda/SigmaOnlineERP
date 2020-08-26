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
    public partial class statementofincome : System.Web.UI.Page
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

            HyperLink option_menu = (HyperLink)Master.FindControl("maccounting_statementofincome");
            option_menu.Attributes.Add("class", "active");
        }

        protected void refresh()
        {
            string strConnString = ConfigurationManager.ConnectionStrings["ConnectionStringSigma"].ConnectionString;
            OleDbConnection conn = new OleDbConnection(strConnString);
            OleDbCommand cmd = new OleDbCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "pr_statement_of_income";
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

        protected void cbyear_SelectedIndexChanged(object sender, EventArgs e)
        {
            refresh();
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

                    ((LinkButton)e.Row.FindControl("lkene")).Font.Bold = true;
                    ((LinkButton)e.Row.FindControl("lkfeb")).Font.Bold = true;
                    ((LinkButton)e.Row.FindControl("lkmar")).Font.Bold = true;
                    ((LinkButton)e.Row.FindControl("lkabr")).Font.Bold = true;
                    ((LinkButton)e.Row.FindControl("lkmay")).Font.Bold = true;
                    ((LinkButton)e.Row.FindControl("lkjun")).Font.Bold = true;
                    ((LinkButton)e.Row.FindControl("lkjul")).Font.Bold = true;
                    ((LinkButton)e.Row.FindControl("lkago")).Font.Bold = true;
                    ((LinkButton)e.Row.FindControl("lksep")).Font.Bold = true;
                    ((LinkButton)e.Row.FindControl("lkoct")).Font.Bold = true;
                    ((LinkButton)e.Row.FindControl("lknov")).Font.Bold = true;
                    ((LinkButton)e.Row.FindControl("lkdic")).Font.Bold = true;
                }

                if (e.Row.Cells[1].Text == "9999999999" || e.Row.Cells[1].Text == "59999999999999" || e.Row.Cells[1].Text == "89999999999999" ||
                    e.Row.Cells[1].Text == "49999999999" || e.Row.Cells[1].Text == "59999999999" || e.Row.Cells[1].Text == "599999999999999" ||
                    e.Row.Cells[1].Text == "8999999999999" || e.Row.Cells[1].Text == "899999999999999")
                {
                    if (e.Row.Cells[1].Text == "59999999999999" || e.Row.Cells[1].Text == "89999999999999")
                    {
                        e.Row.BackColor = System.Drawing.Color.FromName("#D6EAF8");
                        e.Row.Font.Bold = true;
                    }
                    e.Row.Cells[1].Text = "";
                }
                else if (e.Row.Cells[1].Text == "4")
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#EAFAF1");
                    e.Row.Font.Bold = true;
                }
                else if (e.Row.Cells[1].Text == "5" || e.Row.Cells[1].Text == "6")
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#F9EBEA");
                    e.Row.Font.Bold = true;
                }
            }
        }

        protected void gvbalance_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ene")
            {
                string accountid = e.CommandArgument.ToString();

                ViewState["vaccountid"] = accountid;
                ViewState["vdateini"] = "01/01/" + cbyear.SelectedValue;
                ViewState["vdatefin"] = "01/31/" + cbyear.SelectedValue;

                refreshDetail(accountid, new DateTime(Convert.ToInt32(cbyear.SelectedValue), 1, 1), new DateTime(Convert.ToInt32(cbyear.SelectedValue), 1, 31));
            }
            else if (e.CommandName == "feb")
            {
                string accountid = e.CommandArgument.ToString();
                ViewState["vaccountid"] = accountid;
                ViewState["vdateini"] = "02/01/" + cbyear.SelectedValue;
                ViewState["vdatefin"] = "02/" + DateTime.DaysInMonth(Convert.ToInt32(cbyear.SelectedValue), 2).ToString("00") + "/" + cbyear.SelectedValue;

                refreshDetail(accountid, new DateTime(Convert.ToInt32(cbyear.SelectedValue), 2, 1), new DateTime(Convert.ToInt32(cbyear.SelectedValue), 2,
                    DateTime.DaysInMonth(Convert.ToInt32(cbyear.SelectedValue), 2)));
            }
            else if (e.CommandName == "mar")
            {
                string accountid = e.CommandArgument.ToString();
                ViewState["vaccountid"] = accountid;
                ViewState["vdateini"] = "03/01/" + cbyear.SelectedValue;
                ViewState["vdatefin"] = "03/31/" + cbyear.SelectedValue;

                refreshDetail(accountid, new DateTime(Convert.ToInt32(cbyear.SelectedValue), 3, 1), new DateTime(Convert.ToInt32(cbyear.SelectedValue), 3, 31));
            }
            else if (e.CommandName == "abr")
            {
                string accountid = e.CommandArgument.ToString();
                ViewState["vaccountid"] = accountid;
                ViewState["vdateini"] = "04/01/" + cbyear.SelectedValue;
                ViewState["vdatefin"] = "04/30/" + cbyear.SelectedValue;

                refreshDetail(accountid, new DateTime(Convert.ToInt32(cbyear.SelectedValue), 4, 1), new DateTime(Convert.ToInt32(cbyear.SelectedValue), 4, 30));
            }
            else if (e.CommandName == "may")
            {
                string accountid = e.CommandArgument.ToString();
                ViewState["vaccountid"] = accountid;
                ViewState["vdateini"] = "05/01/" + cbyear.SelectedValue;
                ViewState["vdatefin"] = "05/31/" + cbyear.SelectedValue;

                refreshDetail(accountid, new DateTime(Convert.ToInt32(cbyear.SelectedValue), 5, 1), new DateTime(Convert.ToInt32(cbyear.SelectedValue), 5, 31));
            }
            else if (e.CommandName == "jun")
            {
                string accountid = e.CommandArgument.ToString();
                ViewState["vaccountid"] = accountid;
                ViewState["vdateini"] = "06/01/" + cbyear.SelectedValue;
                ViewState["vdatefin"] = "06/30/" + cbyear.SelectedValue;

                refreshDetail(accountid, new DateTime(Convert.ToInt32(cbyear.SelectedValue), 6, 1), new DateTime(Convert.ToInt32(cbyear.SelectedValue), 6, 30));
            }
            else if (e.CommandName == "jul")
            {
                string accountid = e.CommandArgument.ToString();
                ViewState["vaccountid"] = accountid;
                ViewState["vdateini"] = "07/01/" + cbyear.SelectedValue;
                ViewState["vdatefin"] = "07/31/" + cbyear.SelectedValue;

                refreshDetail(accountid, new DateTime(Convert.ToInt32(cbyear.SelectedValue), 7, 1), new DateTime(Convert.ToInt32(cbyear.SelectedValue), 7, 31));
            }
            else if (e.CommandName == "ago")
            {
                string accountid = e.CommandArgument.ToString();
                ViewState["vaccountid"] = accountid;
                ViewState["vdateini"] = "08/01/" + cbyear.SelectedValue;
                ViewState["vdatefin"] = "08/31/" + cbyear.SelectedValue;

                refreshDetail(accountid, new DateTime(Convert.ToInt32(cbyear.SelectedValue), 8, 1), new DateTime(Convert.ToInt32(cbyear.SelectedValue), 8, 31));
            }
            else if (e.CommandName == "sep")
            {
                string accountid = e.CommandArgument.ToString();
                ViewState["vaccountid"] = accountid;
                ViewState["vdateini"] = "09/01/" + cbyear.SelectedValue;
                ViewState["vdatefin"] = "09/30/" + cbyear.SelectedValue;

                refreshDetail(accountid, new DateTime(Convert.ToInt32(cbyear.SelectedValue), 9, 1), new DateTime(Convert.ToInt32(cbyear.SelectedValue), 9, 30));
            }
            else if (e.CommandName == "oct")
            {
                string accountid = e.CommandArgument.ToString();
                ViewState["vaccountid"] = accountid;
                ViewState["vdateini"] = "10/01/" + cbyear.SelectedValue;
                ViewState["vdatefin"] = "10/31/" + cbyear.SelectedValue;

                refreshDetail(accountid, new DateTime(Convert.ToInt32(cbyear.SelectedValue), 10, 1), new DateTime(Convert.ToInt32(cbyear.SelectedValue), 10, 31));
            }
            else if (e.CommandName == "nov")
            {
                string accountid = e.CommandArgument.ToString();
                ViewState["vaccountid"] = accountid;
                ViewState["vdateini"] = "11/01/" + cbyear.SelectedValue;
                ViewState["vdatefin"] = "11/30/" + cbyear.SelectedValue;

                refreshDetail(accountid, new DateTime(Convert.ToInt32(cbyear.SelectedValue), 11, 1), new DateTime(Convert.ToInt32(cbyear.SelectedValue), 11, 30));
            }
            else if (e.CommandName == "dic")
            {
                string accountid = e.CommandArgument.ToString();
                ViewState["vaccountid"] = accountid;
                ViewState["vdateini"] = "12/01/" + cbyear.SelectedValue;
                ViewState["vdatefin"] = "12/31/" + cbyear.SelectedValue;

                refreshDetail(accountid, new DateTime(Convert.ToInt32(cbyear.SelectedValue), 12, 1), new DateTime(Convert.ToInt32(cbyear.SelectedValue), 12, 31));
            }
        }

        protected string monthName(int monthcode)
        {
            switch (monthcode)
            {
                case 1: return "Enero";
                case 2: return "Febrero";
                case 3: return "Marzo";
                case 4: return "Abril";
                case 5: return "Mayo";
                case 6: return "Junio";
                case 7: return "Julio";
                case 8: return "Agosto";
                case 9: return "Septiembre";
                case 10: return "Octubre";
                case 11: return "Noviembre";
                case 12: return "Diciembre";
                default: return "0";
            }
        }

        protected void refreshDetail(string accountid, DateTime dateini, DateTime datefin)
        {
            DataSetAccountingTableAdapters.company_accountsTableAdapter taaccount = new DataSetAccountingTableAdapters.company_accountsTableAdapter();
            DataTable dtaccount = taaccount.GetDataBy_Account(Convert.ToInt32(Session["companyid"]), accountid);
            lbaccount.Text = accountid + ": " + dtaccount.Rows[0]["name"].ToString() + " (" + monthName(dateini.Month) + "-" + cbyear.SelectedValue + ")";

            DataSetAccountingTableAdapters.list_account_movementTableAdapter tadetail = new DataSetAccountingTableAdapters.list_account_movementTableAdapter();
            DataTable dt = tadetail.GetDataBy_Account(Convert.ToInt32(Session["companyid"]), accountid, dateini, datefin);
            gvdetail.DataSource = dt;
            gvdetail.DataBind();

            if (dt.Rows.Count > 0)
            {
                decimal debit = dt.AsEnumerable().Sum(row => row.Field<Decimal>("debit"));
                decimal credit = dt.AsEnumerable().Sum(row => row.Field<Decimal>("credit"));

                gvdetail.FooterRow.Cells[7].Text = debit.ToString("###,###,##0.00");
                gvdetail.FooterRow.Cells[8].Text = credit.ToString("###,###,##0.00");
                gvdetail.FooterRow.Cells[2].Text = dt.Rows.Count.ToString() + " Registros";
            }

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$('#myModalDetail').modal('show');");
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "myModalDetail",
            sb.ToString(), false);

            refresh();
        }

        protected void lkprintdetail_Click(object sender, EventArgs e)
        {
            string _abre = "<script>window.open('http://localhost:81/api/reports/5?format=pdf&inline=true&vcompanyid=" + Session["companyid_hash"] +
                "&vaccountid=" + ViewState["vaccountid"] + "&vuser=" + Session["userid_hash"] + "&vdateini=" + ViewState["vdateini"] + "&vdatefin=" + ViewState["vdatefin"] +
                "','','scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=1100, height=800,left=200,top=100');</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", _abre);

            refresh();
        }

        protected void gvdetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[7].Text == "0.00")
                {
                    e.Row.Cells[7].Text = "";
                }
                if (e.Row.Cells[8].Text == "0.00")
                {
                    e.Row.Cells[8].Text = "";
                }
            }
        }

        protected void gvdetail_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "editjournal")
            {
                int journalid = Convert.ToInt32(e.CommandArgument.ToString());

                DataSetAccountingTableAdapters.journalTableAdapter tajournal = new DataSetAccountingTableAdapters.journalTableAdapter();
                DataTable dtjournal = tajournal.GetDataBy_ID(Convert.ToInt32(Session["companyid"]), journalid);

                if (dtjournal.Rows.Count > 0)
                {
                    Session["RefUrl"] = "statementofincome.aspx";
                    Response.Redirect("newjournal.aspx?c=" + dtjournal.Rows[0]["hashid"].ToString() + "&t=" + ViewState["doctypeid"] + "&p=" + ViewState["conceptid"]);
                }
                refresh();
            }
            else if (e.CommandName == "print")
            {
                int journalid = Convert.ToInt32(e.CommandArgument.ToString());
                DataSetAccountingTableAdapters.journalTableAdapter tajournal = new DataSetAccountingTableAdapters.journalTableAdapter();
                DataTable dtjournal = tajournal.GetDataBy_ID(Convert.ToInt32(Session["companyid"]), journalid);

                string _abre = "<script>window.open('http://localhost:81/api/reports/2?format=pdf&inline=true&vcompanyid=" + Session["companyid_hash"] +
                    "&vjournalid=" + dtjournal.Rows[0]["hashid"] + "&vuser=" + Session["userid_hash"] +
                    "','','scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=1100, height=800,left=200,top=100');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", _abre);

                refresh();
            }
        }
    }
}