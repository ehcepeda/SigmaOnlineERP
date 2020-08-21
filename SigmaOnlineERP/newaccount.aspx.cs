using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaOnlineERP
{
    public partial class newaccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    DataSetAccountingTableAdapters.company_accountsTableAdapter taaccount = new DataSetAccountingTableAdapters.company_accountsTableAdapter();
                    if (Request["c"] != null)
                    {
                        DataTable dtaccount = taaccount.GetDataBy_hash(Convert.ToInt32(Session["companyid"]), Request["c"]);
                        if (dtaccount.Rows.Count > 0)
                        {
                            accountid.Text = dtaccount.Rows[0]["accountid"].ToString();
                            name.Text = dtaccount.Rows[0]["name"].ToString();
                            cbdetail.SelectedValue = dtaccount.Rows[0]["isdetail"].ToString();
                            cborigin.SelectedValue = dtaccount.Rows[0]["origin"].ToString();
                            cbstate.SelectedValue = dtaccount.Rows[0]["isenabled"].ToString();
                            cbtype.SelectedValue = dtaccount.Rows[0]["account_type"].ToString();
                            cbcontrol.SelectedValue = dtaccount.Rows[0]["controlid"].ToString();
                            cbdirect.SelectedValue = dtaccount.Rows[0]["direct"].ToString();
                        }
                    }

                    DataSetAccountingTableAdapters.list_account_controlsTableAdapter tacontrol = new DataSetAccountingTableAdapters.list_account_controlsTableAdapter();
                    cbcontrol.DataSource = tacontrol.GetData(Convert.ToInt32(Session["companyid"]));
                    cbcontrol.DataBind();

                    DataSetAccountingTableAdapters.list_last_accountsTableAdapter talast = new DataSetAccountingTableAdapters.list_last_accountsTableAdapter();
                    gvaccounts.DataSource = talast.GetData(Convert.ToInt32(Session["companyid"]));
                    gvaccounts.DataBind();
                }
            }
        }
        protected void btn_save_Click(object sender, EventArgs e)
        {
            util utilclass = new util();
            DataSetAccountingTableAdapters.company_accountsTableAdapter taaccount = new DataSetAccountingTableAdapters.company_accountsTableAdapter();
            if (Request["c"] == null)
            {
                //verificando existencia
                DataTable dtaccount = taaccount.GetDataBy_Account(Convert.ToInt32(Session["companyid"]), accountid.Text.Trim());
                if (dtaccount.Rows.Count > 0)
                {
                    utilclass.messageinfo(this, "Error!", "Ya existe una Cuenta registrada con este número!", "error", "");
                    accountid.Focus();
                }
                else
                {
                    taaccount.InsertAccount(Convert.ToInt32(Session["companyid"]), accountid.Text.Trim(), name.Text.Trim(), Convert.ToInt32(cbstate.SelectedValue),
                        cbcontrol.SelectedValue, Convert.ToInt32(Session["userid"]), Convert.ToInt32(cbdetail.SelectedValue), cborigin.SelectedValue,
                        Convert.ToInt32(cbdirect.SelectedValue), cbtype.SelectedValue);

                    //limpiando y suigiendo la digitación
                    accountid.Text = "";
                    name.Text = "";
                    accountid.Focus();

                    DataSetAccountingTableAdapters.list_account_controlsTableAdapter tacontrol = new DataSetAccountingTableAdapters.list_account_controlsTableAdapter();
                    cbcontrol.DataSource = tacontrol.GetData(Convert.ToInt32(Session["companyid"]));
                    cbcontrol.DataBind();

                    DataSetAccountingTableAdapters.list_last_accountsTableAdapter talast = new DataSetAccountingTableAdapters.list_last_accountsTableAdapter();
                    gvaccounts.DataSource = talast.GetData(Convert.ToInt32(Session["companyid"]));
                    gvaccounts.DataBind();

                    //Response.Redirect("accounts.aspx?ix=" + Request["ix"]);
                }
            }
            else
            {
                //verificando existencia
                DataTable dtaccount = taaccount.GetDataBy_hash(Convert.ToInt32(Session["companyid"]), Request["c"]);
                if (dtaccount.Rows.Count > 0)
                {
                    if (dtaccount.Rows[0]["accountid"].ToString().Trim() != accountid.Text.Trim())
                    {
                        dtaccount = taaccount.GetDataBy_Account(Convert.ToInt32(Session["companyid"]), accountid.Text.Trim());
                        if (dtaccount.Rows.Count > 0)
                        {
                            utilclass.messageinfo(this, "Error!", "Ya existe una Cuenta registrada con este número!", "error", "");
                            accountid.Focus();
                        }
                        else
                        {
                            //verificando si la cuenta es conrtol de alquien y se cambió
                            dtaccount = taaccount.GetDataBy_hash(Convert.ToInt32(Session["companyid"]), Request["c"]);
                            string ctacontrol = dtaccount.Rows[0]["cuentaid"].ToString();

                            dtaccount = taaccount.GetDataBy_Control(Convert.ToInt32(Session["companyid"]), ctacontrol);
                            if (dtaccount.Rows.Count > 0)
                            {
                                utilclass.messageinfo(this, "Error!", "Ya existe una Cuenta registrada con este número!", "error", "");
                                accountid.Focus();
                            }
                            else
                            {
                                taaccount.UpdateAccount(accountid.Text.Trim(), name.Text.Trim(), Convert.ToInt32(cbstate.SelectedValue), cbcontrol.SelectedValue,
                                cborigin.SelectedValue, cbtype.SelectedValue, accountid.Text.Trim(), Convert.ToInt32(cbdirect.SelectedValue),
                                Convert.ToInt32(cbdetail.SelectedValue), Convert.ToInt32(Session["companyid"]), Request["c"]);

                                Response.Redirect("accounts.aspx?ix=" + Request["ix"]);
                            }
                        }
                    }
                    else
                    {
                        taaccount.UpdateAccount(accountid.Text.Trim(), name.Text.Trim(), Convert.ToInt32(cbstate.SelectedValue), cbcontrol.SelectedValue,
                        cborigin.SelectedValue, cbtype.SelectedValue, accountid.Text.Trim(), Convert.ToInt32(cbdirect.SelectedValue),
                        Convert.ToInt32(cbdetail.SelectedValue), Convert.ToInt32(Session["companyid"]), Request["c"]);

                        Response.Redirect("accounts.aspx?ix=" + Request["ix"]);
                    }
                }
            }
        }

        protected void lk_close_Click(object sender, EventArgs e)
        {
            Response.Redirect("accounts.aspx?ix=" + Request["ix"]);
        }

        protected void cbdetail_SelectedIndexChanged(object sender, EventArgs e)
        {
            cbdirect.Enabled = cbdetail.SelectedValue == "1";
            if (cbdetail.SelectedValue == "0")
            {
                cbdirect.SelectedValue = "0";
            }
        }

        protected void cbtype_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbtype.SelectedValue == "AC")
            {
                cborigin.SelectedValue = "D";
            }
            else if (cbtype.SelectedValue == "PA")
            {
                cborigin.SelectedValue = "C";
            }
            else if (cbtype.SelectedValue == "CA")
            {
                cborigin.SelectedValue = "C";
            }
            else if (cbtype.SelectedValue == "IN")
            {
                cborigin.SelectedValue = "C";
            }
            else if (cbtype.SelectedValue == "CO")
            {
                cborigin.SelectedValue = "D";
            }
            else if (cbtype.SelectedValue == "GA")
            {
                cborigin.SelectedValue = "C";
            }
        }

        protected void cbcontrol_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbcontrol.SelectedValue.Trim().Length > 0)
            {
                DataSetAccountingTableAdapters.company_accountsTableAdapter taaccount = new DataSetAccountingTableAdapters.company_accountsTableAdapter();
                DataTable dtaccount = taaccount.GetDataBy_Account(Convert.ToInt32(Session["companyid"]), cbcontrol.SelectedValue);
                if (dtaccount.Rows.Count > 0)
                {
                    cbtype.SelectedValue = dtaccount.Rows[0]["account_type"].ToString();
                }
            }
        }
    }
}