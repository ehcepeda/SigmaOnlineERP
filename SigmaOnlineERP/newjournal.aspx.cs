using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SigmaOnlineERP
{
    public partial class newjournal : System.Web.UI.Page
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
                    DataSetAccountingTableAdapters.doctypeTableAdapter tatype = new DataSetAccountingTableAdapters.doctypeTableAdapter();
                    cbtype.DataSource = tatype.GetData();
                    cbtype.DataBind();

                    DataSetAccountingTableAdapters.company_dimensionTableAdapter tadimension = new DataSetAccountingTableAdapters.company_dimensionTableAdapter();
                    cbdimension.DataSource = tadimension.GetData(Convert.ToInt32(Session["companyid"]));
                    cbdimension.DataBind();

                    DataSetAccountsPayableTableAdapters.list_company_supplierTableAdapter tasupplier = new DataSetAccountsPayableTableAdapters.list_company_supplierTableAdapter();
                    cbsupplier.DataSource = tasupplier.GetData(Convert.ToInt32(Session["companyid"]));
                    cbsupplier.DataBind();

                    DataSetAdminTableAdapters.list_company_conceptsTableAdapter taconcept = new DataSetAdminTableAdapters.list_company_conceptsTableAdapter();
                    cbconcept.DataSource = taconcept.GetData(Convert.ToInt32(Session["companyid"]));
                    cbconcept.DataBind();

                    DataSetAccountingTableAdapters.journalTableAdapter tajournal = new DataSetAccountingTableAdapters.journalTableAdapter();

                    if (Request["c"] == null)
                    {
                        refresh();
                        cbconcept.SelectedValue = "0";
                        cbsupplier.SelectedValue = "0";
                        cbdimension.SelectedValue = "0";
                        cbtype.SelectedValue = "1";

                        create_date.Text = DateTime.Now.Day.ToString("00") + "-" + DateTime.Now.Month.ToString("00") + "-" + DateTime.Now.Year.ToString();
                        cbtype_SelectedIndexChanged(sender, e);
                        number.Focus();
                    }
                    else
                    {
                        DataTable dtjournal = tajournal.GetDataBy_hash(Convert.ToInt32(Session["companyid"]), Request["c"]);
                        if (dtjournal.Rows.Count > 0)
                        {
                            journalid.Text = dtjournal.Rows[0]["journalid"].ToString();
                            cbtype.SelectedValue = dtjournal.Rows[0]["doctypeid"].ToString();
                            number.Text = dtjournal.Rows[0]["number"].ToString();
                            note.Text = dtjournal.Rows[0]["note"].ToString();
                            create_date.Text = dtjournal.Rows[0]["create_date"].ToString();
                            reference.Text = dtjournal.Rows[0]["reference"].ToString();

                            if (dtjournal.Rows[0]["dimensionid"].ToString().Length > 0)
                            {
                                cbdimension.SelectedValue = dtjournal.Rows[0]["dimensionid"].ToString();
                            }

                            if (dtjournal.Rows[0]["conceptid"].ToString().Length > 0)
                            {
                                cbconcept.SelectedValue = dtjournal.Rows[0]["conceptid"].ToString();
                            }

                            //buscando detalle
                            DataSetAccountingTableAdapters.journal_detailTableAdapter tadetail = new DataSetAccountingTableAdapters.journal_detailTableAdapter();
                            DataTable dtdetail = tadetail.GetDataBy_Journal(Convert.ToInt32(Session["companyid"]), Convert.ToInt32(dtjournal.Rows[0]["journalid"].ToString()));
                            if (dtdetail.Rows.Count > 0)
                            {
                                DataTable myDetail = new DataTable();
                                myDetail.Columns.AddRange(new DataColumn[7]
                                    {
                                new DataColumn("detailid", typeof(Int32)),
                                new DataColumn("accountid", typeof(string)),
                                new DataColumn("name", typeof(string)),
                                new DataColumn("origin", typeof(string)),
                                new DataColumn("debit", typeof(decimal)),
                                new DataColumn("credit", typeof(decimal)),
                                new DataColumn("note", typeof(string))
                                    });

                                for (int i = 0; i < dtdetail.Rows.Count; i++)
                                {
                                    DataRow drItem = myDetail.NewRow();
                                    drItem["detailid"] = dtdetail.Rows[i]["detailid"];
                                    drItem["accountid"] = dtdetail.Rows[i]["accountid"];
                                    drItem["origin"] = dtdetail.Rows[i]["origin"];
                                    drItem["debit"] = dtdetail.Rows[i]["debit"];
                                    drItem["credit"] = dtdetail.Rows[i]["credit"];
                                    drItem["note"] = dtdetail.Rows[i]["note"];
                                    myDetail.Rows.Add(drItem);
                                }
                                ViewState["myDetail"] = myDetail;
                                refresh();
                            }
                        }
                        else
                        {
                            create_date.Text = DateTime.Now.Day.ToString("00") + "-" + DateTime.Now.Month.ToString("00") + "-" + DateTime.Now.Year.ToString();
                            cbtype.SelectedValue = "1";
                            number.Focus();
                            refresh();
                        }
                    }
                }
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
            DataTable myDetail = new DataTable();
            if (ViewState["myDetail"] == null)
            {
                myDetail.Columns.AddRange(new DataColumn[7]
                    {
                                new DataColumn("detailid", typeof(Int32)),
                                new DataColumn("accountid", typeof(string)),
                                new DataColumn("name", typeof(string)),
                                new DataColumn("origin", typeof(string)),
                                new DataColumn("debit", typeof(decimal)),
                                new DataColumn("credit", typeof(decimal)),
                                new DataColumn("note", typeof(string))
                    });

                DataRow drItem = myDetail.NewRow();
                drItem["detailid"] = 1;
                drItem["name"] = "";
                drItem["origin"] = "D";
                drItem["debit"] = 0;
                drItem["credit"] = 0;
                myDetail.Rows.Add(drItem);

                drItem = myDetail.NewRow();
                drItem["detailid"] = 2;
                drItem["name"] = "";
                drItem["origin"] = "C";
                drItem["debit"] = 0;
                drItem["credit"] = 0;
                myDetail.Rows.Add(drItem);

                ViewState["myDetail"] = myDetail;
            }
            else
            {
                myDetail = (DataTable)ViewState["myDetail"];
            }

            if (myDetail.Rows.Count == 0)
            {
                DataRow drItem = myDetail.NewRow();
                drItem["detailid"] = 1;
                drItem["name"] = "";
                drItem["origin"] = "D";
                drItem["debit"] = 0;
                drItem["credit"] = 0;
                myDetail.Rows.Add(drItem);

                ViewState["myDetail"] = myDetail;
            }

            //renumerando
            for (int i = 0; i < myDetail.Rows.Count; i++)
            {
                DataRow drItem = myDetail.Rows[i];
                drItem["detailid"] = (i + 1).ToString();
            }
            ViewState["myDetail"] = myDetail;
            gvdetail.DataSource = myDetail;
            gvdetail.DataBind();

            decimal debit = myDetail.AsEnumerable().Sum(row => row.Field<Decimal>("debit"));
            decimal credit = myDetail.AsEnumerable().Sum(row => row.Field<Decimal>("credit"));

            Label lbtotal_debit = (Label)gvdetail.FooterRow.FindControl("lbtotal_debit");
            Label lbtotal_credit = (Label)gvdetail.FooterRow.FindControl("lbtotal_credit");
            lbtotal_debit.Text = debit.ToString("$###,##0.00");
            lbtotal_credit.Text = credit.ToString("$###,##0.00");

            Label lbdescuadrado = (Label)gvdetail.FooterRow.FindControl("lbdescuadrado");
            lbdescuadrado.Text = "<-- Diferencia de " + (debit > credit ? (debit - credit) : credit - debit).ToString("###,###0.00");
            lbdescuadrado.Visible = debit != credit;
            //btn_save.Enabled = (debit == credit) && (debit > 0);
        }

        protected DataTable getAccounts()
        {
            DataSetAccountingTableAdapters.list_accounts_detailTableAdapter taaccounts = new DataSetAccountingTableAdapters.list_accounts_detailTableAdapter();
            DataTable dtaccounts = taaccounts.GetData(Convert.ToInt32(Session["companyid"]));

            return dtaccounts;
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            DataTable myDetail = (DataTable)ViewState["myDetail"];
            decimal debit = myDetail.AsEnumerable().Sum(row => row.Field<Decimal>("debit"));
            decimal credit = myDetail.AsEnumerable().Sum(row => row.Field<Decimal>("credit"));
            if (debit + credit > 0 && debit != credit)
            {
                util utilclass = new util();
                utilclass.messageinfo(this, "Error!", "Este número de documento está descuadrado!", "error", "");
                number.Focus();
            }
            else
            {
                DataSetAccountingTableAdapters.doctypeTableAdapter tatype = new DataSetAccountingTableAdapters.doctypeTableAdapter();
                DataTable dttype = tatype.GetDataBy_ID(Convert.ToInt32(cbtype.SelectedValue));

                DataSetAccountingTableAdapters.journalTableAdapter tajournal = new DataSetAccountingTableAdapters.journalTableAdapter();

                Nullable<Int32> dimensionid = null;
                Nullable<Int32> supplierid = null;
                Nullable<Int32> conceptid = null;

                if (Request["c"] == null)
                {
                    //verificando si el numero existe
                    DataTable dtjournal = tajournal.GetDataBy_Number(Convert.ToInt32(Session["companyid"]), Convert.ToInt32(cbtype.SelectedValue), number.Text.Trim());
                    if (dtjournal.Rows.Count > 0)
                    {
                        util utilclass = new util();
                        utilclass.messageinfo(this, "Error!", "Este número de documento ya existe para este tipo!", "error", "");
                        number.Focus();
                    }
                    else
                    {
                        //buscando número del mes
                        int lastSequence = tajournal.LastMonthSequence(Convert.ToInt32(Session["companyid"]), Convert.ToInt32(cbtype.SelectedValue),
                            new DateTime(Convert.ToInt32(create_date.Text.Substring(6, 4)), Convert.ToInt32(create_date.Text.Substring(3, 2)), 1),
                            new DateTime(Convert.ToInt32(create_date.Text.Substring(6, 4)), Convert.ToInt32(create_date.Text.Substring(3, 2)), Convert.ToInt32(create_date.Text.Substring(0, 2)))).Value;

                        int journalid = tajournal.LastJournal(Convert.ToInt32(Session["companyid"])).Value + 1;

                        //insertando maestro
                        tajournal.InsertJournal(Convert.ToInt32(Session["companyid"]), journalid, Convert.ToInt32(cbtype.SelectedValue),
                            new DateTime(Convert.ToInt32(create_date.Text.Substring(6, 4)), Convert.ToInt32(create_date.Text.Substring(3, 2)), Convert.ToInt32(create_date.Text.Substring(0, 2))),
                            number.Text.Trim(), Convert.ToInt32(Session["userid"]), note.Text.Trim(),
                            (cbdimension.SelectedValue == "0" || cbdimension.SelectedValue.Length == 0) ? dimensionid : Convert.ToInt32(cbdimension.SelectedValue),
                            dttype.Rows[0]["code"].ToString(), FormsAuthentication.HashPasswordForStoringInConfigFile(journalid.ToString(), "SHA1"),
                            (cbsupplier.SelectedValue == "0" || cbsupplier.SelectedValue.Length == 0) ? supplierid : Convert.ToInt32(cbsupplier.SelectedValue),
                            lastSequence + 1, reference.Text.Trim(),
                            (cbconcept.SelectedValue == "0" || cbconcept.SelectedValue.Length == 0) ? conceptid : Convert.ToInt32(cbconcept.SelectedValue));

                        //insertando detalle
                        myDetail = (DataTable)ViewState["myDetail"];
                        DataSetAccountingTableAdapters.journal_detailTableAdapter tadetail = new DataSetAccountingTableAdapters.journal_detailTableAdapter();

                        for (int i = 0; i < myDetail.Rows.Count; i++)
                        {
                            tadetail.InsertDetail(Convert.ToInt32(Session["companyid"]), journalid, Convert.ToInt32(myDetail.Rows[i]["detailid"]),
                                myDetail.Rows[i]["accountid"].ToString().Trim(), myDetail.Rows[i]["origin"].ToString().Trim(), Convert.ToDecimal(myDetail.Rows[i]["debit"]),
                                Convert.ToDecimal(myDetail.Rows[i]["credit"]), dimensionid, myDetail.Rows[i]["note"].ToString().Trim());
                        }

                        ViewState["myDetail"] = null;
                        create_date.Text = DateTime.Now.Day.ToString("00") + "-" + DateTime.Now.Month.ToString("00") + "-" + DateTime.Now.Year.ToString();
                        note.Text = "";
                        number.Text = "";
                        reference.Text = "";
                        cbconcept.SelectedValue = "0";
                        cbsupplier.SelectedValue = "0";
                        cbdimension.SelectedValue = "0";
                        cbtype_SelectedIndexChanged(sender, e);

                        refresh();
                        number.Focus();
                    }
                }
                else
                {
                    DataTable dtjournal = tajournal.GetDataBy_Number(Convert.ToInt32(Session["companyid"]), Convert.ToInt32(cbtype.SelectedValue), number.Text.Trim());
                    if (dtjournal.Rows.Count > 0 && dtjournal.Rows[0]["hashid"].ToString() != Request["c"].ToString())
                    {
                        util utilclass = new util();
                        utilclass.messageinfo(this, "Error!", "Este número de documento ya existe para este tipo!", "error", "");
                        number.Focus();
                    }
                    else
                    {
                        dtjournal = tajournal.GetDataBy_hash(Convert.ToInt32(Session["companyid"]), Request["c"]);
                        if (dtjournal.Rows.Count > 0)
                        {
                            tajournal.UpdateJournal(Convert.ToInt32(cbtype.SelectedValue), new DateTime(Convert.ToInt32(create_date.Text.Substring(6, 4)),
                                Convert.ToInt32(create_date.Text.Substring(3, 2)), Convert.ToInt32(create_date.Text.Substring(0, 2))), number.Text.Trim(),
                                note.Text.Trim(), (cbdimension.SelectedValue == "0" || cbdimension.SelectedValue.Length == 0) ? dimensionid : Convert.ToInt32(cbdimension.SelectedValue),
                                dttype.Rows[0]["code"].ToString(), (cbsupplier.SelectedValue == "0" || cbsupplier.SelectedValue.Length == 0) ? supplierid : Convert.ToInt32(cbsupplier.SelectedValue),
                                reference.Text.Trim(), (cbconcept.SelectedValue == "0" || cbconcept.SelectedValue.Length == 0) ? conceptid : Convert.ToInt32(cbconcept.SelectedValue),
                                Convert.ToInt32(Session["companyid"]), Convert.ToInt32(dtjournal.Rows[0]["journalid"]));

                            ViewState["myDetail"] = null;
                            Response.Redirect("journalentry.aspx");
                        }
                    }
                }
            }
        }

        protected void lk_close_Click(object sender, EventArgs e)
        {
            ViewState["myDetail"] = null;
            Response.Redirect("journalentry.aspx");
        }

        protected void gvdetail_RowEditing(object sender, GridViewEditEventArgs e)
        {
            btn_save.Enabled = false;

            gvdetail.EditIndex = e.NewEditIndex;
            refresh();

            //llenando dropdown de cuenta
            Label lbedit_accountid = (Label)gvdetail.Rows[gvdetail.EditIndex].FindControl("lbedit_accountid");
            DropDownList edit_cbname = (DropDownList)gvdetail.Rows[gvdetail.EditIndex].FindControl("edit_cbname");
            edit_cbname.DataSource = getAccounts();
            edit_cbname.DataBind();
            edit_cbname.SelectedValue = lbedit_accountid.Text;
            string lborigin = "";

            //buscando última línea
            DataTable myDetail = (DataTable)ViewState["myDetail"];
            DataRow dtrow = myDetail.Rows[gvdetail.EditIndex];

            for (int i = 0; i < myDetail.Rows.Count; i++)
            {
                DataRow drItem = myDetail.Rows[i];
                if (i == gvdetail.EditIndex)
                {
                    lborigin = drItem["origin"].ToString();
                }
                else
                {
                    LinkButton lkedit = (LinkButton)gvdetail.Rows[i].FindControl("lkedit");
                    lkedit.Visible = false;

                    LinkButton lkdelete = (LinkButton)gvdetail.Rows[i].FindControl("lkdelete");
                    lkdelete.Visible = false;
                }
            }

            //llenando dropdown de origen
            DropDownList cborigin = (DropDownList)gvdetail.Rows[gvdetail.EditIndex].FindControl("cborigin");
            cborigin.SelectedValue = lborigin;
            cborigin_SelectedIndexChanged(sender, e);
        }

        protected void gvdetail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    //This part is directly gerneate the ddl's item
                    DropDownList drop = (DropDownList)e.Row.FindControl("edit_cbname");
                    drop.DataSource = getAccounts();
                    drop.DataBind();

                    LinkButton lkrow = (LinkButton)e.Row.FindControl("lkrow");
                    lkrow.Visible = true;
                }
                else
                {
                    Label lborigin = (Label)e.Row.FindControl("lborigin");
                    Label lbdebit = (Label)e.Row.FindControl("lbdebit");
                    Label lbcredit = (Label)e.Row.FindControl("lbcredit");

                    lbdebit.Enabled = lborigin.Text == "Crédito";
                    lbcredit.Enabled = lborigin.Text == "Débito";

                    Label lbaccountid = (Label)e.Row.FindControl("lbaccountid");
                    DropDownList drop = (DropDownList)e.Row.FindControl("cbname");

                    drop.DataSource = getAccounts();
                    drop.DataBind();
                    drop.SelectedValue = lbaccountid.Text;

                    LinkButton lkrow = (LinkButton)e.Row.FindControl("lkrow");
                    lkrow.Visible = false;
                }
            }
        }

        protected void cborigin_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList cborigin = (DropDownList)gvdetail.Rows[gvdetail.EditIndex].FindControl("cborigin");
            TextBox edit_debit = (TextBox)gvdetail.Rows[gvdetail.EditIndex].FindControl("edit_debit");
            edit_debit.Visible = cborigin.SelectedValue == "D";

            TextBox edit_credit = (TextBox)gvdetail.Rows[gvdetail.EditIndex].FindControl("edit_credit");
            edit_credit.Visible = cborigin.SelectedValue == "C";

            if (cborigin.SelectedValue == "C")
            {
                edit_debit.Text = "0.00";
            }
            else
            {
                edit_credit.Text = "0.00";
            }
        }

        protected void gvdetail_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvdetail.EditIndex = -1;
            refresh();
        }

        protected void lkaddline_Click(object sender, EventArgs e)
        {
            DataTable myDetail = (DataTable)ViewState["myDetail"];

            //buscando última línea
            DataRow dtrow = myDetail.Rows[myDetail.Rows.Count - 1];
            int detailid = Convert.ToInt32(dtrow["detailid"].ToString());

            DataRow drItem = myDetail.NewRow();
            drItem["detailid"] = detailid + 1;
            drItem["name"] = "";
            drItem["origin"] = "D";
            drItem["debit"] = 0;
            drItem["credit"] = 0;
            myDetail.Rows.Add(drItem);

            ViewState["myDetail"] = myDetail;
            gvdetail.DataSource = myDetail;

            gvdetail.EditIndex = myDetail.Rows.Count - 1;
            gvdetail.DataBind();
        }

        protected void gvdetail_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            DropDownList edit_cbname = (DropDownList)gvdetail.Rows[gvdetail.EditIndex].FindControl("edit_cbname");
            Label lbedit_accountid = (Label)gvdetail.Rows[gvdetail.EditIndex].FindControl("lbedit_accountid");
            DropDownList cborigin = (DropDownList)gvdetail.Rows[gvdetail.EditIndex].FindControl("cborigin");
            TextBox edit_credit = (TextBox)gvdetail.Rows[gvdetail.EditIndex].FindControl("edit_credit");
            TextBox edit_debit = (TextBox)gvdetail.Rows[gvdetail.EditIndex].FindControl("edit_debit");
            TextBox edit_note = (TextBox)gvdetail.Rows[gvdetail.EditIndex].FindControl("edit_note");

            DataTable myDetail = (DataTable)ViewState["myDetail"];

            for (int i = 0; i < myDetail.Rows.Count; i++)
            {
                DataRow drItem = myDetail.Rows[i];
                if (i == gvdetail.EditIndex)
                {
                    drItem["accountid"] = lbedit_accountid.Text;
                    drItem["debit"] = edit_debit.Text;
                    drItem["credit"] = edit_credit.Text;
                    drItem["origin"] = cborigin.SelectedValue;
                    drItem["note"] = edit_note.Text;
                }
            }

            ViewState["myDetail"] = myDetail;
            gvdetail.EditIndex = -1;
            refresh();
        }

        protected void edit_cbname_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList cbname = (DropDownList)gvdetail.Rows[gvdetail.EditIndex].FindControl("edit_cbname");
            Label lbedit_accountid = (Label)gvdetail.Rows[gvdetail.EditIndex].FindControl("lbedit_accountid");
            lbedit_accountid.Text = cbname.SelectedValue;
        }

        protected void gvdetail_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label lbdetailid = (Label)gvdetail.Rows[e.RowIndex].FindControl("lbdetailid");

            DataTable myDetail = (DataTable)ViewState["myDetail"];
            for (int i = 0; i < myDetail.Rows.Count; i++)
            {
                DataRow drItem = myDetail.Rows[i];
                if (myDetail.Rows[i]["detailid"].ToString() != lbdetailid.Text)
                {
                    drItem["detailid"] = myDetail.Rows[i]["detailid"].ToString();
                    drItem["accountid"] = myDetail.Rows[i]["accountid"].ToString();
                    drItem["debit"] = myDetail.Rows[i]["debit"].ToString();
                    drItem["credit"] = myDetail.Rows[i]["credit"].ToString();
                    drItem["origin"] = myDetail.Rows[i]["origin"].ToString();
                    drItem["note"] = myDetail.Rows[i]["note"].ToString();
                }
                else
                {
                    myDetail.Rows[i].Delete();
                }
            }
            ViewState["myDetail"] = myDetail;
            gvdetail.EditIndex = -1;
            refresh();
        }

        protected void cbtype_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Request["c"] == null)
            {
                //buscando número del mes
                DataSetAccountingTableAdapters.journalTableAdapter tajournal = new DataSetAccountingTableAdapters.journalTableAdapter();
                int lastSequence = tajournal.LastMonthSequence(Convert.ToInt32(Session["companyid"]), Convert.ToInt32(cbtype.SelectedValue),
                    new DateTime(Convert.ToInt32(create_date.Text.Substring(6, 4)), Convert.ToInt32(create_date.Text.Substring(3, 2)), 1),
                    new DateTime(Convert.ToInt32(create_date.Text.Substring(6, 4)), Convert.ToInt32(create_date.Text.Substring(3, 2)), Convert.ToInt32(create_date.Text.Substring(0, 2)))).Value;

                number.Text = create_date.Text.Substring(6, 4) + create_date.Text.Substring(3, 2) + "-" + (lastSequence + 1).ToString("00");
            }
        }

        protected void cbconcept_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable myDetail = (DataTable)ViewState["myDetail"];
            decimal debit = myDetail.AsEnumerable().Sum(row => row.Field<Decimal>("debit"));
            decimal credit = myDetail.AsEnumerable().Sum(row => row.Field<Decimal>("credit"));
            if (debit + credit == 0)
            {
                //buscando la cuenta
                DataSetAdminTableAdapters.company_conceptsTableAdapter taconcept = new DataSetAdminTableAdapters.company_conceptsTableAdapter();
                DataTable dtconcept = taconcept.GetDataBy_ID(Convert.ToInt32(Session["companyid"]), Convert.ToInt32(cbconcept.SelectedValue));
                if (dtconcept.Rows.Count > 0)
                {
                    string accountid = dtconcept.Rows[0]["accountid"].ToString();
                    if (accountid.Trim().Length > 0)
                    {
                        DataSetAccountingTableAdapters.company_accountsTableAdapter taaccount = new DataSetAccountingTableAdapters.company_accountsTableAdapter();
                        DataTable dtaccount = taaccount.GetDataBy_Account(Convert.ToInt32(Session["companyid"]), accountid);
                        if (dtaccount.Rows.Count > 0)
                        {
                            string origin = dtaccount.Rows[0]["origin"].ToString();

                            //colocando cuenta en el detalle
                            ViewState["myDetail"] = null;
                            myDetail = new DataTable();
                            myDetail.Columns.AddRange(new DataColumn[7]
                                {
                                new DataColumn("detailid", typeof(Int32)),
                                new DataColumn("accountid", typeof(string)),
                                new DataColumn("name", typeof(string)),
                                new DataColumn("origin", typeof(string)),
                                new DataColumn("debit", typeof(decimal)),
                                new DataColumn("credit", typeof(decimal)),
                                new DataColumn("note", typeof(string))
                                });

                            DataRow drItem = myDetail.NewRow();
                            drItem["detailid"] = 1;
                            drItem["name"] = "";
                            drItem["origin"] = "D";
                            drItem["debit"] = 0;
                            drItem["credit"] = 0;
                            if (origin == "D")
                            {
                                drItem["accountid"] = accountid;
                            }
                            myDetail.Rows.Add(drItem);

                            drItem = myDetail.NewRow();
                            drItem["detailid"] = 2;
                            drItem["name"] = "";
                            drItem["origin"] = "C";
                            drItem["debit"] = 0;
                            drItem["credit"] = 0;
                            if (origin == "C")
                            {
                                drItem["accountid"] = accountid;
                            }
                            myDetail.Rows.Add(drItem);

                            ViewState["myDetail"] = myDetail;
                            refresh();
                        }
                    }
                }
            }
        }
    }
}