using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaOnlineERP
{
    public partial class config : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                refreshncf();
            }
        }

        protected void refreshncf()
        {
            DataSetAdminTableAdapters.list_company_ncfTableAdapter tancf = new DataSetAdminTableAdapters.list_company_ncfTableAdapter();
            DataTable dtncf = tancf.GetDataBy_Company(Convert.ToInt32(Session["companyid"]));
            gvncf.DataSource = dtncf;
            gvncf.DataBind();
        }

        protected void gvncf_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvncf.EditIndex = e.NewEditIndex;
            refreshncf();
        }

        protected void gvncf_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "activate")
            {
                int ncfid = Convert.ToInt32(e.CommandArgument.ToString());

                DataSetAdminTableAdapters.company_ncfTableAdapter tancf = new DataSetAdminTableAdapters.company_ncfTableAdapter();
                tancf.UpdateEstatus(1, Convert.ToInt32(Session["companyid"]), ncfid);
                refreshncf();
            }
            else if (e.CommandName == "inactivate")
            {
                int ncfid = Convert.ToInt32(e.CommandArgument.ToString());

                DataSetAdminTableAdapters.company_ncfTableAdapter tancf = new DataSetAdminTableAdapters.company_ncfTableAdapter();
                tancf.UpdateEstatus(0, Convert.ToInt32(Session["companyid"]), ncfid);
                refreshncf();
            }
        }

        protected void gvncf_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvncf.EditIndex = -1;
            refreshncf();
        }

        protected void gvncf_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int ncfid = Convert.ToInt32(gvncf.DataKeys[gvncf.EditIndex].Values[0]);

            DataSetAdminTableAdapters.company_ncfTableAdapter tancf = new DataSetAdminTableAdapters.company_ncfTableAdapter();

            Nullable<DateTime> nullncf_vence = null;

            Label lbserie = gvncf.Rows[gvncf.EditIndex].FindControl("lbserie") as Label;
            TextBox edit_desde = gvncf.Rows[gvncf.EditIndex].FindControl("edit_desde") as TextBox;
            TextBox edit_hasta = gvncf.Rows[gvncf.EditIndex].FindControl("edit_hasta") as TextBox;
            TextBox edit_secuencia = gvncf.Rows[gvncf.EditIndex].FindControl("edit_secuencia") as TextBox;
            TextBox edit_vence = gvncf.Rows[gvncf.EditIndex].FindControl("edit_vence") as TextBox;

            tancf.UpdateNCF(lbserie.Text.Trim(), Convert.ToInt32(edit_desde.Text.Trim()), Convert.ToInt32(edit_hasta.Text.Trim()),
                edit_vence.Text.Trim().Length == 0 ? nullncf_vence : new DateTime(Convert.ToInt32(edit_vence.Text.Trim().Substring(6, 4)),
                Convert.ToInt32(edit_vence.Text.Trim().Substring(3, 2)), Convert.ToInt32(edit_vence.Text.Trim().Substring(0, 2))),
                Convert.ToInt32(edit_secuencia.Text.Trim()), Convert.ToInt32(Session["companyid"]), ncfid);

            gvncf.EditIndex = -1;
            refreshncf();

            /*util utilclass = new util();
            utilclass.messageinfo(this, "Error!", ncfid.ToString(), "error", "");*/


            //Finding the controls from Gridview for the row which is going to update  
            /*Label id = gvncf.Rows[e.RowIndex].FindControl("lbl_ID") as Label;
            TextBox name = GridView1.Rows[e.RowIndex].FindControl("txt_Name") as TextBox;
            TextBox city = GridView1.Rows[e.RowIndex].FindControl("txt_City") as TextBox;
            con = new SqlConnection(cs);
            con.Open();
            //updating the record  
            SqlCommand cmd = new SqlCommand("Update tbl_Employee set Name='" + name.Text + "',City='" + city.Text + "' where ID=" + Convert.ToInt32(id.Text), con);
            cmd.ExecuteNonQuery();
            con.Close();
            //Setting the EditIndex property to -1 to cancel the Edit mode in Gridview  
            GridView1.EditIndex = -1;
            //Call ShowData method for displaying updated data  
            ShowData();*/
        }
    }
}