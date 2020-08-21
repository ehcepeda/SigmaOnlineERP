using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace SigmaOnlineERP
{
    public class util
    {
        public void messageinfo(Page page, string titulo, string mensaje, string tipo, string wlocation)
        {
            if (wlocation == "")
            {
                ScriptManager.RegisterStartupScript(page, typeof(Page), "showerror", "swal('" + titulo + "', '" + mensaje + "', '" + tipo + "');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(page, typeof(Page), "showerror", "swal({title: '" + titulo + "', text: '" + mensaje + "', type: '" + tipo +
                    "'}, function (){window.location.href=\"" + wlocation + "\";});", true);
            }
        }
    }
}