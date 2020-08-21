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
                refresh();
            }
        }

        protected void refresh()
        {
            DataSetAccountingTableAdapters.list_journalTableAdapter tajouornal = new DataSetAccountingTableAdapters.list_journalTableAdapter();
            var qjournal = tajouornal.GetDataBy_Date(Convert.ToInt32(Session["companyid"]),
                new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day),
                new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day)).AsEnumerable().
                Where(row => row.Field<String>("number").ToUpper().Contains(tbsearch.Text.Trim().ToUpper())).ToList();

            //DataTable dtaccounts = taaccounts.GetData(Convert.ToInt32(Session["companyid"]));
            gvjournal.DataSource = qjournal;
            gvjournal.DataBind();

            if (qjournal.Count == 0)
            {
                DataTable myCompany = new DataTable();
                myCompany.Columns.AddRange(new DataColumn[9]
                    {
                        new DataColumn("journalid", typeof(Int32)),
                        new DataColumn("doctype", typeof(string)),
                        new DataColumn("create_date", typeof(DateTime)),
                        new DataColumn("number", typeof(string)),
                        new DataColumn("note", typeof(string)),
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
        }

        protected void btn_add_Click(object sender, EventArgs e)
        {

        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {

        }

        protected void btn_export_Click(object sender, EventArgs e)
        {

        }

        protected void btn_search_Click(object sender, EventArgs e)
        {

        }

        protected void gvjournal_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void gvjournal_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void gvjournal_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
    }
}