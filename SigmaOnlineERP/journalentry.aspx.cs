using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaOnlineERP
{
    public partial class journalentry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataSetAdminTableAdapters.list_company_conceptsTableAdapter taconcept = new DataSetAdminTableAdapters.list_company_conceptsTableAdapter();
                cbconcept.DataSource = taconcept.GetData(Convert.ToInt32(Session["companyid"]));
                cbconcept.DataBind();
                cbconcept.SelectedValue = "0";


                date_start.Text = "01 -" + DateTime.Now.Month.ToString("00") + "-" + DateTime.Now.Year.ToString();
                date_end.Text = DateTime.Now.Day.ToString("00") + "-" + DateTime.Now.Month.ToString("00") + "-" + DateTime.Now.Year.ToString("00");

                refresh();
            }
        }

        protected void Page_PreInit(object sender, EventArgs e)
        {
            System.Web.UI.HtmlControls.HtmlGenericControl option_main = (System.Web.UI.HtmlControls.HtmlGenericControl)Master.FindControl("maccounting");
            option_main.Attributes.Add("class", "active mm-active");

            HyperLink option_menu = (HyperLink)Master.FindControl("maccounting_journal");
            option_menu.Attributes.Add("class", "active");
        }

        protected void refresh()
        {
            DataSetAccountingTableAdapters.list_journalTableAdapter tajouornal = new DataSetAccountingTableAdapters.list_journalTableAdapter();
            var qjournal = tajouornal.GetDataBy_Date(Convert.ToInt32(Session["companyid"]),
                new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1),
                new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day)).AsEnumerable().
                Where(row => (row.Field<String>("number").ToUpper() + row.Field<String>("note").ToUpper()).Contains(tbsearch.Text.Trim().ToUpper())
                && row.Field<String>("concept").ToUpper().Contains(cbconcept.SelectedItem.Text.ToUpper())).ToList();

            gvjournal.DataSource = qjournal;
            gvjournal.DataBind();

            if (qjournal.Count == 0)
            {
                DataTable myCompany = new DataTable();
                myCompany.Columns.AddRange(new DataColumn[10]
                    {
                        new DataColumn("journalid", typeof(Int32)),
                        new DataColumn("doctype", typeof(string)),
                        new DataColumn("create_date", typeof(DateTime)),
                        new DataColumn("number", typeof(string)),
                        new DataColumn("note", typeof(string)),
                        new DataColumn("concept", typeof(string)),
                        new DataColumn("direct", typeof(Int32)),
                        new DataColumn("dimension", typeof(string)),
                        new DataColumn("debit", typeof(decimal)),
                        new DataColumn("credit", typeof(decimal))
                    });

                DataRow drItem = myCompany.NewRow();
                drItem["doctype"] = "";
                drItem["debit"] = "0.00";
                drItem["credit"] = "0.00";
                myCompany.Rows.Add(drItem);
                gvjournal.DataSource = myCompany;
                gvjournal.DataBind();
            }

            decimal debit = qjournal.Sum(row => row.Field<Decimal>("debit"));
            decimal credit = qjournal.Sum(row => row.Field<Decimal>("credit"));

            gvjournal.FooterRow.Cells[8].Text = debit.ToString("$###,###,##0.00");
            gvjournal.FooterRow.Cells[9].Text = credit.ToString("$###,###,##0.00");

        }

        protected void btn_add_Click(object sender, EventArgs e)
        {
            Response.Redirect("newjournal.aspx");
        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {
            refresh();
        }

        protected void btn_export_Click(object sender, EventArgs e)
        {
            string _abre = "<script>window.open('http://localhost:81/api/reports/2?format=pdf&inline=true&vcompanyid=" + Session["companyid_hash"] +
            "&vuser=" + Session["userid_hash"] + "','','scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=1100, height=800,left=200,top=100');</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", _abre);
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            refresh();
        }

        protected void gvjournal_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void gvjournal_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {
                int journalid = Convert.ToInt32(e.CommandArgument.ToString());

                DataSetAccountingTableAdapters.journalTableAdapter tajournal = new DataSetAccountingTableAdapters.journalTableAdapter();
                DataTable dtjournal = tajournal.GetDataBy_ID(Convert.ToInt32(Session["companyid"]), journalid);

                if (dtjournal.Rows.Count > 0)
                {
                    Response.Redirect("newjournal.aspx?c=" + dtjournal.Rows[0]["hashid"].ToString());
                }
            }
            else if (e.CommandName == "erase")
            {
                int journalid = Convert.ToInt32(e.CommandArgument.ToString());

                DataSetAccountingTableAdapters.journalTableAdapter tajournal = new DataSetAccountingTableAdapters.journalTableAdapter();
                DataSetAccountingTableAdapters.journal_detailTableAdapter tadetail = new DataSetAccountingTableAdapters.journal_detailTableAdapter();
                tadetail.DeleteJournal(Convert.ToInt32(Session["companyid"]), journalid);
                tajournal.DeleteJournal(Convert.ToInt32(Session["companyid"]), journalid);

                refresh();

                util utilclass = new util();
                utilclass.messageinfo(this, "Satisfactorio!", "Se ha Eliminado la Entrada!", "success", "");
            }
            else if (e.CommandName == "print")
            {
                int journalid = Convert.ToInt32(e.CommandArgument.ToString());
                DataSetAccountingTableAdapters.journalTableAdapter tajournal = new DataSetAccountingTableAdapters.journalTableAdapter();
                DataTable dtjournal = tajournal.GetDataBy_ID(Convert.ToInt32(Session["companyid"]), journalid);

                string _abre = "<script>window.open('http://localhost:81/api/reports/2?format=pdf&inline=true&vcompanyid=" + Session["companyid_hash"] +
                    "&vjournalid=" + dtjournal.Rows[0]["hashid"]+"&vuser=" + Session["userid_hash"] + 
                    "','','scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=1100, height=800,left=200,top=100');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", _abre);
            }
        }

        protected void gvjournal_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void cbconcept_SelectedIndexChanged(object sender, EventArgs e)
        {
            refresh();
        }
    }
}