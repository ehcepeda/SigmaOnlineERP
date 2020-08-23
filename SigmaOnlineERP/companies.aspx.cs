using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaOnlineERP
{
    public partial class companies : System.Web.UI.Page
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
            DataSetSecurityTableAdapters.list_companyTableAdapter tacompany = new DataSetSecurityTableAdapters.list_companyTableAdapter();
            DataTable dtcompany = tacompany.GetDataBy_User(Convert.ToInt32(Session["userid"]));
            gvcompanies.DataSource = dtcompany;
            gvcompanies.DataBind();

            if (dtcompany.Rows.Count == 0)
            {
                DataTable myCompany = new DataTable();
                myCompany.Columns.AddRange(new DataColumn[10]
                    {
                        new DataColumn("companyid", typeof(Int32)),
                        new DataColumn("name", typeof(string)),
                        new DataColumn("razon_social", typeof(string)),
                        new DataColumn("rnc", typeof(string)),
                        new DataColumn("phone1", typeof(string)),
                        new DataColumn("phone2", typeof(string)),
                        new DataColumn("monthly_fee", typeof(decimal)),
                        new DataColumn("isenabled", typeof(Int32)),
                        new DataColumn("state", typeof(string)),
                        new DataColumn("city", typeof(string))
                    });

                DataRow drItem = myCompany.NewRow();
                drItem["name"] = "";
                drItem["monthly_fee"] = "0.00";
                myCompany.Rows.Add(drItem);
                gvcompanies.DataSource = myCompany;
                gvcompanies.DataBind();
            }
        }

        protected void btn_add_Click(object sender, EventArgs e)
        {
            Response.Redirect("newcompany.aspx");
        }

        protected void gvcompanies_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {
                int companyid = Convert.ToInt32(e.CommandArgument.ToString());

                DataSetSecurityTableAdapters.companyTableAdapter tacompany = new DataSetSecurityTableAdapters.companyTableAdapter();
                DataTable dtcompany = tacompany.GetDataBy_ID(companyid);
                if (dtcompany.Rows.Count > 0)
                {
                    Response.Redirect("newcompany.aspx?c=" + dtcompany.Rows[0]["hashid"].ToString());
                }
            }
            else if (e.CommandName == "inactivate")
            {
                int companyid = Convert.ToInt32(e.CommandArgument.ToString());

                DataSetSecurityTableAdapters.companyTableAdapter tacompany = new DataSetSecurityTableAdapters.companyTableAdapter();
                tacompany.UpdateStatus(0, companyid);

                refresh();

                util utilclass = new util();
                utilclass.messageinfo(this, "Satisfactorio!", "Se ha Inactivado esta Empresa!", "success", "");
            }
            else if (e.CommandName == "reactivate")
            {
                int companyid = Convert.ToInt32(e.CommandArgument.ToString());

                DataSetSecurityTableAdapters.companyTableAdapter tacompany = new DataSetSecurityTableAdapters.companyTableAdapter();
                tacompany.UpdateStatus(1, companyid);

                refresh();

                util utilclass = new util();
                utilclass.messageinfo(this, "Satisfactorio!", "Se ha Activado esta Empresa nuevamente!", "success", "");
            }
        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {
            refresh();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
               server control at run time. */
        }

        protected void btn_export_Click(object sender, EventArgs e)
        {
            gvcompanies.AllowPaging = false;
            gvcompanies.PageIndex = 0;
            refresh();

            gvcompanies.Columns[0].Visible = false;

            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            string FileName = "Empresas_" + DateTime.Now + ".xls";
            StringWriter strwritter = new StringWriter();
            HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
            gvcompanies.GridLines = GridLines.Both;
            gvcompanies.HeaderStyle.Font.Bold = true;
            gvcompanies.RenderControl(htmltextwrtter);
            Response.Write(strwritter.ToString());
            Response.End();

            refresh();
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {

        }
    }
}