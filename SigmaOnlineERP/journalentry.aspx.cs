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
            if (Session["userid"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else if (!IsPostBack)
            {
                ViewState["doctype"] = "";
                ViewState["concept"] = "";
                ViewState["conceptid"] = "0";
                ViewState["doctypeid"] = "0";

                if (Request["t"] != null)
                {
                    ViewState["doctypeid"] = Request["t"];
                }

                if (Request["p"] != null)
                {
                    ViewState["conceptid"] = Request["p"];
                }

                date_start.Text = "01-" + DateTime.Now.Month.ToString("00") + "-" + DateTime.Now.Year.ToString();
                date_end.Text = DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month).ToString("00") + "-" + DateTime.Now.Month.ToString("00") + "-" + DateTime.Now.Year.ToString("00");

                DataSetAccountingTableAdapters.list_doctypeTableAdapter tadoctype = new DataSetAccountingTableAdapters.list_doctypeTableAdapter();
                dldoctype.DataSource = tadoctype.GetData();
                dldoctype.DataBind();

                DataSetAdminTableAdapters.list_company_conceptsTableAdapter taconcept = new DataSetAdminTableAdapters.list_company_conceptsTableAdapter();
                dlconcept.DataSource = taconcept.GetData(Convert.ToInt32(Session["companyid"]));
                dlconcept.DataBind();

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
            //buscando concepto
            if (ViewState["conceptid"].ToString() != "0")
            {
                DataSetAdminTableAdapters.company_conceptsTableAdapter taconcept = new DataSetAdminTableAdapters.company_conceptsTableAdapter();
                DataTable dtconcept = taconcept.GetDataBy_ID(Convert.ToInt32(Session["companyid"]), Convert.ToInt32(ViewState["conceptid"]));
                ViewState["concept"] = dtconcept.Rows[0]["name"].ToString();
            }
            else
            {
                ViewState["concept"] = "";
            }

            //buscando concepto
            if (ViewState["doctypeid"].ToString() != "0")
            {
                DataSetAccountingTableAdapters.doctypeTableAdapter tadoctype = new DataSetAccountingTableAdapters.doctypeTableAdapter();
                DataTable dtdoctype = tadoctype.GetDataBy_ID(Convert.ToInt32(ViewState["doctypeid"]));
                ViewState["doctype"] = dtdoctype.Rows[0]["name"].ToString();
            }
            else
            {
                ViewState["doctype"] = "";
            }

            DataSetAccountingTableAdapters.list_journalTableAdapter tajouornal = new DataSetAccountingTableAdapters.list_journalTableAdapter();
            var qjournal = tajouornal.GetDataBy_Date(Convert.ToInt32(Session["companyid"]),
                new DateTime(Convert.ToInt32(date_start.Text.Substring(6, 4)), Convert.ToInt32(date_start.Text.Substring(3, 2)), Convert.ToInt32(date_start.Text.Substring(0, 2))),
                new DateTime(Convert.ToInt32(date_end.Text.Substring(6, 4)), Convert.ToInt32(date_end.Text.Substring(3, 2)), Convert.ToInt32(date_end.Text.Substring(0, 2)))).AsEnumerable().
                Where(row => (row.Field<String>("number").ToUpper() + row.Field<String>("note").ToUpper()).Contains(tbsearch.Text.Trim().ToUpper())
                && row.Field<String>("doctype").ToUpper().ToUpper().Contains(ViewState["doctype"].ToString().ToUpper())
                && row.Field<String>("concept").ToUpper().ToUpper().Contains(ViewState["concept"].ToString().ToUpper())).ToList();

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
            else
            {
                gvjournal.FooterRow.Cells[2].Text = qjournal.Count.ToString() + " Registros";
            }

            decimal debit = qjournal.Sum(row => row.Field<Decimal>("debit"));
            decimal credit = qjournal.Sum(row => row.Field<Decimal>("credit"));

            gvjournal.FooterRow.Cells[8].Text = debit.ToString("$###,###,##0.00");
            gvjournal.FooterRow.Cells[9].Text = credit.ToString("$###,###,##0.00");

        }

        protected void btn_add_Click(object sender, EventArgs e)
        {
            Response.Redirect("newjournal.aspx?t=" + ViewState["doctypeid"] + "&p=" + ViewState["conceptid"]);
        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {
            refresh();
        }

        protected void btn_export_Click(object sender, EventArgs e)
        {
            refresh();
            string dateini = date_start.Text.Trim().Substring(3, 2) + "/" + date_start.Text.Trim().Substring(0, 2) + "/" + date_start.Text.Trim().Substring(6, 4);
            string datefin = date_end.Text.Trim().Substring(3, 2) + "/" + date_end.Text.Trim().Substring(0, 2) + "/" + date_end.Text.Trim().Substring(6, 4);

            string _abre = "<script>window.open('http://localhost:81/api/reports/3?format=pdf&inline=true&vcompanyid=" + Session["companyid_hash"] +
                "&vdateini=" + dateini + "&vdatefin=" + datefin + "&vuser=" + Session["userid_hash"] + "&vdoctype=" + ViewState["doctypeid"] +
                "&vconcept=" + ViewState["conceptid"] + "','','scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=1100, height=800,left=200,top=100');</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", _abre);
         }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            refresh();
        }

        protected void gvjournal_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvjournal.PageIndex = e.NewPageIndex;
            gvjournal.SelectedIndex = -1;
            refresh();
        }

        protected void gvjournal_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "editjournal")
            {
                int journalid = Convert.ToInt32(e.CommandArgument.ToString());

                DataSetAccountingTableAdapters.journalTableAdapter tajournal = new DataSetAccountingTableAdapters.journalTableAdapter();
                DataTable dtjournal = tajournal.GetDataBy_ID(Convert.ToInt32(Session["companyid"]), journalid);

                if (dtjournal.Rows.Count > 0)
                {
                    Response.Redirect("newjournal.aspx?c=" + dtjournal.Rows[0]["hashid"].ToString() + "&t=" + ViewState["doctypeid"] + "&p=" + ViewState["conceptid"]);
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

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
               server control at run time. */
        }

        protected void cbdoctype_SelectedIndexChanged(object sender, EventArgs e)
        {
            refresh();
        }

        protected void dldoctype_SelectedIndexChanged(object sender, EventArgs e)
        {
            lbtype.Text = dldoctype.SelectedValue.ToString();
        }

        protected void dldoctype_ItemCommand(object source, DataListCommandEventArgs e)
        {
            ViewState["doctypeid"] = e.CommandArgument.ToString();
            ViewState["doctype"] = e.CommandName;
            refresh();
        }

        protected void dlconcept_ItemCommand(object source, DataListCommandEventArgs e)
        {
            ViewState["conceptid"] = e.CommandArgument.ToString();
            ViewState["concept"] = e.CommandName;
            refresh();
        }
    }
}