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
    public partial class user_profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    DataSetSecurityTableAdapters.usersTableAdapter tausers = new DataSetSecurityTableAdapters.usersTableAdapter();
                    DataTable dtusers = tausers.GetDataBy_username(Session["username"].ToString());
                    if (dtusers.Rows.Count > 0)
                    {
                        name.Text = " ";
                        lbinfo_email.Text = dtusers.Rows[0]["email"].ToString();
                        lbinfo_username.Text = dtusers.Rows[0]["username"].ToString();
                        img_profile.ImageUrl = "./assets/images/users/" + Session["image_name"].ToString();

                        name.Text = dtusers.Rows[0]["name"].ToString();
                        primaryphone.Text = dtusers.Rows[0]["primaryphone"].ToString();
                        secundaryphone.Text = dtusers.Rows[0]["secundaryphone"].ToString();

                        social_facebook.Text = dtusers.Rows[0]["social_facebook"].ToString();
                        social_instagram.Text = dtusers.Rows[0]["social_instagram"].ToString();
                        social_twitter.Text = dtusers.Rows[0]["social_twitter"].ToString();

                        cbcurrency.SelectedValue = dtusers.Rows[0]["currencyid"].ToString();
                        cblanguage.SelectedValue = dtusers.Rows[0]["languageid"].ToString();
                        cbmessages.SelectedValue = dtusers.Rows[0]["send_messages"].ToString();

                        if (dtusers.Rows[0]["isadmin"].ToString() == "1")
                        {
                            lbinfo_rol.Text = "Administrador";
                        }
                        else
                        {
                            lbinfo_rol.Text = "Usuario";
                        }
                    }
                }
            }
        }

        protected void btn_save_info_Click(object sender, EventArgs e)
        {
            DataSetSecurityTableAdapters.usersTableAdapter tausers = new DataSetSecurityTableAdapters.usersTableAdapter();
            tausers.UpdateInfo(name.Text.Trim(), primaryphone.Text.Trim(), secundaryphone.Text.Trim(),
                social_facebook.Text.Trim(), social_instagram.Text.Trim(), social_twitter.Text.Trim(),
                Convert.ToInt32(cbcurrency.SelectedValue), Convert.ToInt32(cblanguage.SelectedValue),
                Convert.ToInt32(cbmessages.SelectedValue), Convert.ToInt32(Session["userid"]));

            util utilclass = new util();
            utilclass.messageinfo(this, "Ok!", "Se ha guardado tu información satisfactoriamente!", "success", "");
        }

        protected void btsaveimage_Click(object sender, EventArgs e)
        {
            if (this.FileUpload1.HasFile)
            {
                //subiendo archivo
                string fileName = System.IO.Path.GetFileName(this.FileUpload1.PostedFile.FileName);
                string extension = System.IO.Path.GetExtension(fileName);
                string folderName = Server.MapPath("./assets/images/users/");
                string fotousuario = fileName;
                string nombre = "userid_" + Session["userid"].ToString() + extension;
                fileName = System.IO.Path.Combine(folderName, nombre);

                if (File.Exists(System.IO.Path.Combine(folderName, nombre)))
                {
                    if (nombre != "nouser.png")
                    {
                        File.Delete(System.IO.Path.Combine(folderName, nombre));
                    }
                }

                this.FileUpload1.PostedFile.SaveAs(fileName);

                //actualizando la tabla de usuario
                Session["image_name"] = nombre;
                DataSetSecurityTableAdapters.usersTableAdapter tausers = new DataSetSecurityTableAdapters.usersTableAdapter();

                tausers.UpdateImage(nombre, Convert.ToInt32(Session["userid"]));

                tausers.UpdateInfo(name.Text.Trim(), primaryphone.Text.Trim(), secundaryphone.Text.Trim(),
                    social_facebook.Text.Trim(), social_instagram.Text.Trim(), social_twitter.Text.Trim(),
                    Convert.ToInt32(cbcurrency.SelectedValue), Convert.ToInt32(cblanguage.SelectedValue),
                    Convert.ToInt32(cbmessages.SelectedValue), Convert.ToInt32(Session["userid"]));

                Response.Redirect("User-profile.aspx");
            }
        }
    }
}