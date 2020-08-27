using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.OleDb;

namespace SigmaOnlineERP
{
    public partial class generaldiary : System.Web.UI.Page
    {
        int currentId = 0;
        int currentDoctype = 0;
        decimal subTotal_debit = 0;
        decimal subTotal_credit = 0;
        decimal total_debit = 0;
        decimal total_credit = 0;
        int subTotalRowIndex = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else if (!IsPostBack)
            {
                date_start.Text = "01-" + DateTime.Now.Month.ToString("00") + "-" + DateTime.Now.Year.ToString();
                date_end.Text = DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month).ToString("00") + "-" + DateTime.Now.Month.ToString("00") + "-" + DateTime.Now.Year.ToString("00");

                DataSetAccountingTableAdapters.list_doctypeTableAdapter tadoctype = new DataSetAccountingTableAdapters.list_doctypeTableAdapter();
                cbdoctype.DataSource = tadoctype.GetData();
                cbdoctype.DataBind();

                DataSetAdminTableAdapters.list_company_conceptsTableAdapter taconcept = new DataSetAdminTableAdapters.list_company_conceptsTableAdapter();
                cbconcept.DataSource = taconcept.GetData(Convert.ToInt32(Session["companyid"]));
                cbconcept.DataBind();

                refresh();
            }
        }

        protected void Page_PreInit(object sender, EventArgs e)
        {
            System.Web.UI.HtmlControls.HtmlGenericControl option_main = (System.Web.UI.HtmlControls.HtmlGenericControl)Master.FindControl("maccounting");
            option_main.Attributes.Add("class", "active mm-active");

            HyperLink option_menu = (HyperLink)Master.FindControl("maccounting_diary");
            option_menu.Attributes.Add("class", "active");
        }

        protected void refresh()
        {
            string query = "";
            query += "select j.doctypeid, j.journalid, j.number, t.name as doctype, format(j.create_date, 'dd-MM-yyyy') as create_date, ";
            query += "j.create_date as create_date_real, d.accountid, c.name, isnull(i.name, '') as dimension, ";
            query += "isnull(d.note,'') as note, d.origin, isnull(l.name, '') as dimension_general, isnull(s.name,'') as concept, ";
            query += "sum(d.debit) as debit, sum(d.credit) as credit ";
            query += "from journal j left outer join company_dimension l on (j.dimensionid = l.dimensionid) ";
            query += "left outer join company_concepts s on (j.companyid = s.companyid and j.conceptid = s.conceptid), journal_detail d ";
            query += "left outer join company_dimension i on (d.dimensionid = i.dimensionid), company_accounts c, doctype t ";
            query += "where j.journalid = d.journalid and j.companyid = d.companyid and d.companyid = c.companyid ";
            query += "and d.accountid = c.accountid and j.doctypeid = t.doctypeid and j.companyid = " + Session["companyid"].ToString() + " ";
            query += "and j.create_date between '" + date_start.Text.Substring(6, 4) + date_start.Text.Substring(3, 2) + date_start.Text.Substring(0, 2) + "' and '";
            query += date_end.Text.Substring(6, 4) + date_end.Text.Substring(3, 2) + date_end.Text.Substring(0, 2) + "' ";

            if (cbconcept.SelectedValue != "0")
            {
                query += "and j.conceptid = " + cbconcept.SelectedValue + " ";
            }

            if (cbdoctype.SelectedValue != "0")
            {
                query += "and j.doctypeid = " + cbdoctype.SelectedValue + " ";
            }

            query += "and j.number+c.name+isnull(d.note,'')+d.accountid like '%" + tbsearch.Text + "%' ";

            query += "group by j.doctypeid, j.journalid, j.number, t.name, format(j.create_date, 'dd-MM-yyyy'),";
            query += "j.create_date, d.accountid, c.name, isnull(i.name, ''),";
            query += "d.note, d.origin, isnull(l.name, ''), isnull(s.name,'') ";
            query += "order by j.create_date, j.doctypeid, j.journalid, 13 desc, d.accountid";

            string conString = ConfigurationManager.ConnectionStrings["ConnectionStringSigma"].ConnectionString;
            using (OleDbConnection con = new OleDbConnection(conString))
            {
                using (OleDbCommand cmd = new OleDbCommand(query))
                {
                    using (OleDbDataAdapter sda = new OleDbDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            if (dt.Rows.Count > 0)
                            {
                                gvjournal.DataSource = dt;
                                gvjournal.DataBind();
                            }
                            else
                            {
                                DataTable MyDetail = new DataTable();
                                MyDetail.Columns.AddRange(new DataColumn[15]
                                    {
                                        new DataColumn("doctypeid", typeof(Int32)),
                                        new DataColumn("journalid", typeof(Int32)),
                                        new DataColumn("number", typeof(string)),
                                        new DataColumn("doctype", typeof(string)),
                                        new DataColumn("create_date", typeof(string)),
                                        new DataColumn("create_date_real", typeof(DateTime)),
                                        new DataColumn("accountid", typeof(string)),
                                        new DataColumn("name", typeof(string)),
                                        new DataColumn("dimension", typeof(string)),
                                        new DataColumn("note", typeof(string)),
                                        new DataColumn("origin", typeof(string)),
                                        new DataColumn("dimension_general", typeof(string)),
                                        new DataColumn("concept", typeof(string)),
                                        new DataColumn("debit", typeof(decimal)),
                                        new DataColumn("credit", typeof(decimal))
                                    });

                                DataRow drItem = MyDetail.NewRow();
                                drItem["journalid"] = "0";
                                drItem["doctypeid"] = "0";
                                drItem["doctype"] = "";
                                drItem["debit"] = "0.00";
                                drItem["credit"] = "0.00";
                                MyDetail.Rows.Add(drItem);

                                gvjournal.DataSource = MyDetail;
                                gvjournal.DataBind();
                            }
                        }
                    }
                }
            }
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            refresh();
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

            string _abre = "<script>window.open('http://localhost:81/api/reports/4?format=pdf&inline=true&vcompanyid=" + Session["companyid_hash"] +
                "&vdateini=" + dateini + "&vdatefin=" + datefin + "&vuser=" + Session["userid_hash"] + "&vdoctype=" + cbdoctype.SelectedValue +
                "&vconcept=" + cbconcept.SelectedValue + "','','scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=1100, height=800,left=200,top=100');</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", _abre);

            refresh();
        }

        protected void btn_add_Click(object sender, EventArgs e)
        {
            Session["RefUrl"] = "generaldiary.aspx";
            Response.Redirect("newjournal.aspx?t=" + cbdoctype.SelectedValue + "&p=" + cbconcept.SelectedValue);
        }

        protected void gvjournal_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvjournal.PageIndex = e.NewPageIndex;
            gvjournal.SelectedIndex = -1;
            refresh();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
               server control at run time. */
        }

        protected void gvjournal_RowCreated(object sender, GridViewRowEventArgs e)
        {
            subTotal_debit = 0;
            subTotal_credit = 0;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                try
                {
                    DataTable dt = (e.Row.DataItem as DataRowView).DataView.Table;

                    //DataTable dt = (e.Row.DataItem as DataRowView).DataView.Table;
                    int orderId = Convert.ToInt32(dt.Rows[e.Row.RowIndex]["journalid"]);
                    int doctypeid = Convert.ToInt32(dt.Rows[e.Row.RowIndex]["doctypeid"]);
                    total_debit += Convert.ToDecimal(dt.Rows[e.Row.RowIndex]["debit"]);
                    total_credit += Convert.ToDecimal(dt.Rows[e.Row.RowIndex]["credit"]);
                    if (orderId != currentId || doctypeid != currentDoctype)
                    {
                        if (e.Row.RowIndex > 0)
                        {
                            for (int i = subTotalRowIndex; i < e.Row.RowIndex; i++)
                            {
                                subTotal_debit += Convert.ToDecimal(gvjournal.Rows[i].Cells[7].Text);
                                subTotal_credit += Convert.ToDecimal(gvjournal.Rows[i].Cells[8].Text);

                            }
                            this.AddTotalRow("Sub Total", subTotal_debit.ToString("N2"), subTotal_credit.ToString("N2"));
                            subTotalRowIndex = e.Row.RowIndex;
                        }
                        currentId = orderId;
                        currentDoctype = doctypeid;
                    }
                }
                catch
                {

                }
            }
        }

        private void AddTotalRow(string labelText, string value_debit, string value_credit)
        {
            GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Normal);
            row.BackColor = ColorTranslator.FromHtml("#F9F9F9");
            row.Font.Bold = true;
            row.Cells.AddRange(new TableCell[9] { new TableCell(), new TableCell(), new TableCell(), new TableCell(), new TableCell(), new TableCell(), 
                                        new TableCell { Text = labelText, HorizontalAlign = HorizontalAlign.Right},
                                        new TableCell { Text = value_debit, HorizontalAlign = HorizontalAlign.Right},
                                        new TableCell { Text = value_credit, HorizontalAlign = HorizontalAlign.Right} });

            gvjournal.Controls[0].Controls.Add(row);
        }

        protected void gvjournal_DataBound(object sender, EventArgs e)
        {
            for (int i = subTotalRowIndex; i < gvjournal.Rows.Count; i++)
            {
                subTotal_debit += Convert.ToDecimal(gvjournal.Rows[i].Cells[7].Text);
                subTotal_credit += Convert.ToDecimal(gvjournal.Rows[i].Cells[8].Text);
            }
            this.AddTotalRow("Sub Total", subTotal_debit.ToString("N2"), subTotal_credit.ToString("N2"));
            this.AddTotalRow("Total", total_debit.ToString("N2"), total_credit.ToString("N2"));
        }

        protected void cbdoctype_SelectedIndexChanged(object sender, EventArgs e)
        {
            refresh();
        }

        protected void cbconcept_SelectedIndexChanged(object sender, EventArgs e)
        {
            refresh();
        }
    }
}