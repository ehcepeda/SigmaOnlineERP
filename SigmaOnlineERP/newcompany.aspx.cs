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
    public partial class newcompany : System.Web.UI.Page
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
                    DataSetAdminTableAdapters.countryTableAdapter tacoountry = new DataSetAdminTableAdapters.countryTableAdapter();
                    cbcountry.DataSource = tacoountry.GetData();
                    cbcountry.DataBind();

                    DataSetAdminTableAdapters.currencyTableAdapter tacurrency = new DataSetAdminTableAdapters.currencyTableAdapter();
                    cbcurrency.DataSource = tacurrency.GetData();
                    cbcurrency.DataBind();

                    if (Request["c"] != null)
                    {
                        DataSetSecurityTableAdapters.companyTableAdapter tacompany = new DataSetSecurityTableAdapters.companyTableAdapter();
                        DataTable dtcompany = tacompany.GetDataBy_hashid(Request["c"]);
                        if (dtcompany.Rows.Count > 0)
                        {
                            company_rnc.Text = dtcompany.Rows[0]["rnc"].ToString();
                            company_name.Text = dtcompany.Rows[0]["name"].ToString();
                            company_razon.Text = dtcompany.Rows[0]["razon_social"].ToString();
                            cbcountry.SelectedValue = dtcompany.Rows[0]["countryid"].ToString();
                            cbcurrency.SelectedValue = dtcompany.Rows[0]["currencyid"].ToString();
                            company_url.Text = dtcompany.Rows[0]["url"].ToString();
                            company_address1.Text = dtcompany.Rows[0]["address1"].ToString();
                            company_address2.Text = dtcompany.Rows[0]["address2"].ToString();
                            company_state.Text = dtcompany.Rows[0]["state"].ToString();
                            company_city.Text = dtcompany.Rows[0]["city"].ToString();
                            company_phone1.Text = dtcompany.Rows[0]["phone1"].ToString();
                            company_phone2.Text = dtcompany.Rows[0]["phone2"].ToString();
                            company_email_info.Text = dtcompany.Rows[0]["email_info"].ToString();
                            company_email_sales.Text = dtcompany.Rows[0]["email_sales"].ToString();
                            company_email_support.Text = dtcompany.Rows[0]["email_support"].ToString();
                            company_email_norepply.Text = dtcompany.Rows[0]["email_noreply"].ToString();
                            social_facebook.Text = dtcompany.Rows[0]["facebook"].ToString();
                            social_instagram.Text = dtcompany.Rows[0]["instagram"].ToString();
                            social_twitter.Text = dtcompany.Rows[0]["twitter"].ToString();

                            img_logo.ImageUrl = "assets/images/logos/" + dtcompany.Rows[0]["image_logo"].ToString();
                            img_stamp.ImageUrl = "assets/images/stamps/" + dtcompany.Rows[0]["image_stamp"].ToString();

                            company_rnc.ReadOnly = true;
                            company_razon.ReadOnly = true;
                            company_name.ReadOnly = true;
                        }
                    }
                    else
                    {
                        img_logo.ImageUrl = "assets/images/logos/yourlogo.jpg";
                        img_stamp.ImageUrl = "assets/images/stamps/yourstamp.jpg";
                    }
                }
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            util utilclass = new util();
            DataSetSecurityTableAdapters.companyTableAdapter tacompany = new DataSetSecurityTableAdapters.companyTableAdapter();
            DataSetSecurityTableAdapters.user_companyTableAdapter tausercompany = new DataSetSecurityTableAdapters.user_companyTableAdapter();

            string yourlogo = "yourlogo.jpg";
            string yourstamp = "yourstamp.jpg";

            //grabando archivo del logo
            if (img_logo.ImageUrl != "assets/images/logos/yourlogo.jpg")
            {
                string nombre = img_logo.ImageUrl.Substring(20);
                Session["image_logo"] = nombre;
                yourlogo = nombre;
            }

            //grabando archivo del stamp
            if (img_stamp.ImageUrl != "assets/images/stamps/yourstamp.jpg")
            {
                string nombre = img_stamp.ImageUrl.Substring(21);
                Session["image_stamp"] = nombre;
                yourstamp = nombre;
            }

            if (Request["c"] == null)
            {
                //buscando rnc
                DataTable dtcompany = tacompany.GetDataBy_RNC(company_rnc.Text.Trim());
                if (dtcompany.Rows.Count > 0)
                {
                    //buscando empresa en el usuario
                    DataTable dtusercompany = tausercompany.GetData_User_Company(Convert.ToInt32(dtcompany.Rows[0]["companyid"]), Convert.ToInt32(Session["userid"]));
                    if (dtusercompany.Rows.Count == 0)
                    {
                        //insertando empresa en el usuario
                        tausercompany.InsertUserCompany(Convert.ToInt32(Session["userid"]), Convert.ToInt32(dtcompany.Rows[0]["companyid"]));
                    }
                    else
                    {
                        utilclass.messageinfo(this, "Error!", "Ya existe una Empresa registrada con este RNC!", "error", "");
                    }
                }
                else
                {
                    //insertando empresa
                    tacompany.InsertCompany(company_name.Text.Trim(), company_rnc.Text.Trim(), Convert.ToInt32(cbcountry.SelectedValue), company_url.Text.Trim(),
                        company_phone1.Text.Trim(), company_phone2.Text.Trim(), company_zip.Text.Trim(), Convert.ToInt32(cbcurrency.SelectedValue),
                        social_facebook.Text.Trim(), social_instagram.Text.Trim(), company_email_info.Text.Trim(), company_email_sales.Text.Trim(),
                        company_email_support.Text.Trim(), company_email_norepply.Text.Trim(), company_razon.Text.Trim(), company_address1.Text.Trim(),
                        company_address2.Text.Trim(), social_twitter.Text.Trim(), company_state.Text.Trim(), company_city.Text.Trim(),
                        yourlogo, yourstamp);

                    //buscando empresa
                    dtcompany = tacompany.GetDataBy_RNC(company_rnc.Text.Trim());

                    //insertando empresa en el usuario
                    tausercompany.InsertUserCompany(Convert.ToInt32(Session["userid"]), Convert.ToInt32(dtcompany.Rows[0]["companyid"]));

                    Response.Redirect("companies.aspx");
                }
            }
            else
            {
                DataTable dtcompany = tacompany.GetDataBy_hashid(Request["c"]);

                tacompany.UpdateInfo(Convert.ToInt32(cbcountry.SelectedValue), company_url.Text.Trim(), company_phone1.Text.Trim(), company_phone2.Text.Trim(),
                    company_zip.Text.Trim(), Convert.ToInt32(cbcurrency.SelectedValue), social_facebook.Text.Trim(), social_instagram.Text.Trim(),
                    company_email_info.Text.Trim(), company_email_sales.Text.Trim(), company_email_support.Text.Trim(), company_email_norepply.Text.Trim(),
                    company_address1.Text.Trim(), company_address2.Text.Trim(), social_twitter.Text.Trim(), company_state.Text.Trim(), company_city.Text.Trim(),
                    yourlogo, yourstamp, Convert.ToInt32(dtcompany.Rows[0]["companyid"]));

                Response.Redirect("companies.aspx");
            }
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            if (company_rnc.Text.Trim().Length > 0)
            {
                DataSetAdminTableAdapters.rncTableAdapter tarnc = new DataSetAdminTableAdapters.rncTableAdapter();
                DataTable dtrnc = tarnc.GetDataBy_RNC(company_rnc.Text.Trim());
                if (dtrnc.Rows.Count > 0)
                {
                    company_name.Text = dtrnc.Rows[0]["nombre_comercial"].ToString();
                    company_razon.Text = dtrnc.Rows[0]["razon_social"].ToString();
                }
                else
                {
                    company_name.Text = "** RNC no existe en la DGII **";
                    company_razon.Text = "** RNC no existe en la DGII **";
                }
            }
        }

        protected void btsaveimage_Click(object sender, EventArgs e)
        {
            if (this.FileUpload1.HasFile)
            {
                //subiendo archivo
                string fileName = System.IO.Path.GetFileName(this.FileUpload1.PostedFile.FileName);
                string extension = System.IO.Path.GetExtension(fileName);
                string folderName = Server.MapPath("./assets/images/logos/");
                string fotousuario = fileName;
                string nombre = "company_" + company_rnc.Text.Trim() + extension;
                fileName = System.IO.Path.Combine(folderName, nombre);

                if (File.Exists(System.IO.Path.Combine(folderName, nombre)))
                {
                    if (nombre != "yourlogo.jpg")
                    {
                        File.Delete(System.IO.Path.Combine(folderName, nombre));
                    }
                }

                this.FileUpload1.PostedFile.SaveAs(fileName);
                img_logo.ImageUrl = "assets/images/logos/" + nombre;
            }
        }

        protected void btsaveimage_stamp_Click(object sender, EventArgs e)
        {
            if (this.FileUpload2.HasFile)
            {
                //subiendo archivo
                string fileName = System.IO.Path.GetFileName(this.FileUpload2.PostedFile.FileName);
                string extension = System.IO.Path.GetExtension(fileName);
                string folderName = Server.MapPath("./assets/images/stamps/");
                string fotousuario = fileName;
                string nombre = "company_" + company_rnc.Text.Trim() + extension;
                fileName = System.IO.Path.Combine(folderName, nombre);

                if (File.Exists(System.IO.Path.Combine(folderName, nombre)))
                {
                    if (nombre != "yourstamp.jpg")
                    {
                        File.Delete(System.IO.Path.Combine(folderName, nombre));
                    }
                }

                this.FileUpload2.PostedFile.SaveAs(fileName);
                img_stamp.ImageUrl = "assets/images/stamps/" + nombre;
            }
        }

        protected void lk_close_Click(object sender, EventArgs e)
        {
            Response.Redirect("companies.aspx");
        }
    }
}