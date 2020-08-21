<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSigma.Master" AutoEventWireup="true" CodeBehind="newcompany.aspx.cs" Inherits="SigmaOnlineERP.newcompany" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="assets/libs/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet">
    <script type="text/javascript" src="assets/libs/jquery/jquery.min.js"></script>

    <!-- Sweet Alerts js -->
    <script type="text/javascript" src="assets/js/sweetalert.min.js"></script>
    <link href="assets/js/sweetalert.min.css" rel="stylesheet" type="text/css" />

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" LoadScriptsBeforeUI="true"></asp:ScriptManager>
    <div class="main-content">
        <div class="page-content">
            <div class="container-fluid">
                <!-- start page title -->
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box d-flex align-items-center justify-content-between">
                            <h4 class="mb-0 font-size-18">Mi empresa</h4>
                            <div class="page-title-right">
                                <ol class="breadcrumb m-0">
                                    <li class="breadcrumb-item"><a href="companies.aspx">Empresas</a></li>
                                    <li class="breadcrumb-item active">Empresa</li>
                                </ol>
                            </div>
                        </div>  
                    </div>
                </div>
                <!-- end page title -->

                <div class="row">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-body">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <div class="row mb-2">
                                            <div class="col-sm-4">
                                                <h4 class="card-title mb-4">Datos de mi Empresa</h4>
                                            </div>
                                            <div class="col-sm-8">
                                                <div class="text-sm-right">
                                                    <asp:Button ID="btn_save" runat="server" Text="Grabar" CssClass="btn btn-info waves-effect waves-light" 
                                                        CausesValidation="true" OnClick="btn_save_Click" />
                                                    <asp:LinkButton ID="lk_close" runat="server" CssClass="btn btn-danger waves-effect waves-light"
                                                        ausesValidation="false" OnClick="lk_close_Click">Salir</asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                        <div role="form">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="company_name">Nombre</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-text label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_name" runat="server" placeholder="Nombre comercial" CssClass="form-control" required
                                                                oninvalid="this.setCustomValidity('Debes introducir el Nombre Comercial de la empresa')" MaxLength="100"
                                                                oninput="setCustomValidity('')"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="company_razon">Razón social</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-text label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_razon" runat="server" placeholder="Razón social" CssClass="form-control" required
                                                                oninvalid="this.setCustomValidity('Debes introducir la Razón social de la empresa')" MaxLength="200"
                                                                oninput="setCustomValidity('')"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="company_rnc">RNC</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-id-card label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_rnc" runat="server" placeholder="RNC" CssClass="form-control" required
                                                                oninvalid="this.setCustomValidity('Debes introducir el RNC')" MaxLength="200"
                                                                oninput="setCustomValidity('')"></asp:TextBox>
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text">
                                                                    <asp:LinkButton ID="btn_search" runat="server" OnClick="btn_search_Click">
                                                                        <i class="bx bx-search-alt"></i>
                                                                    </asp:LinkButton>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="cbcountry">País</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-globe label-icon"></i></div>
                                                            </div>
                                                            <asp:DropDownList ID="cbcountry" runat="server" CssClass="form-control" DataValueField="countryid"
                                                                DataTextField="code">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="cbcurrency">Moneda</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-dollar label-icon"></i></div>
                                                            </div>
                                                            <asp:DropDownList ID="cbcurrency" runat="server" CssClass="form-control" DataValueField="currencyid"
                                                                DataTextField="code">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="company_url">Website</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-link label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_url" runat="server" placeholder="Página web" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="company_address1">Dirección 1</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-street-view label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_address1" runat="server" placeholder="Calle, número" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="company_address2">Dirección 2</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-street-view label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_address2" runat="server" placeholder="Edificio, piso, sector" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="company_city">Ciudad</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-street-view label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_city" runat="server" placeholder="Ciudad" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="company_state">Estado o provincia</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-street-view label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_state" runat="server" placeholder="Estado o provincia" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="company_phone1">Teléfono 1</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-phone label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_phone1" runat="server" placeholder="Teléfono principal" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="company_phone2">Teléfono 2</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-phone label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_phone2" runat="server" placeholder="Teléfono móvil/fax" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="company_zip">Código postal</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-phone label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_zip" runat="server" placeholder="Zipcode" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card overflow-hidden">
                            <div class="bg-soft-primary">
                                <div class="row">
                                    <div class="col-7">
                                        <div class="text-primary p-3">
                                            <h5 class="text-primary">Hola !</h5>
                                            <p>En esta sección propircionas los datos generales de tu Empresa, información de contacto y redes sociales.</p>
                                        </div>
                                    </div>
                                    <div class="col-5 align-self-end">
                                        <img src="assets/images/profile-img.png" alt="" class="img-fluid" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h2 class="card-title">Imagén para el Logo y el Sello</h2>
                                <p></p>
                                <p class="card-title-desc">
                                </p>
                                <div class="row">
                                    <div class="col-md-6" style="text-align: center;">
                                        <asp:Button ID="btsaveimage" runat="server" Text="Button" Style="display: none;" OnClick="btsaveimage_Click" />
                                        <asp:FileUpload ID="FileUpload1" runat="server" Style="display: none;" onchange="SaveImage();" />
                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                            <ContentTemplate>
                                                <asp:ImageButton ID="img_logo" runat="server" class="rounded mr-2" Height="80" OnClientClick="OpenFiledialog();" CausesValidation="true" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                    <div class="col-md-6" style="text-align: center;">
                                        <asp:Button ID="btsaveimage_stamp" runat="server" Text="Button" Style="display: none;" OnClick="btsaveimage_stamp_Click" />
                                        <asp:FileUpload ID="FileUpload2" runat="server" Style="display: none;" onchange="SaveImageStamp();" />
                                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                            <ContentTemplate>
                                                <asp:ImageButton ID="img_stamp" runat="server" class="rounded mr-2" Height="80" OnClientClick="OpenFiledialogStamp();" CausesValidation="true" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="card-title mb-4">Correos</h4>
                                        <div role="form">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="company_email_info">Informaciones</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-envelope label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_email_info" runat="server" placeholder="Correo para informaciones" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="company_email_sales">Ventas</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-envelope label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_email_sales" runat="server" placeholder="Correo para ventas" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="company_email_support">Soporte</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-envelope label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_email_support" runat="server" placeholder="Correo para soporte" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="company_email_norepply">No repply</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-envelope label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="company_email_norepply" runat="server" placeholder="Correo para soporte" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end row -->

                        <div class="row">
                            <div class="col-lg-8">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="card-title mb-4">Redes sociales</h4>
                                        <div role="form">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="social_facebook">Facebook</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bxl-facebook label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="social_facebook" runat="server" placeholder="Id de facebook" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="social_instagram">Instagram</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bxl-instagram label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="social_instagram" runat="server" placeholder="Id de instagram" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="social_twitter">Twitter</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bxl-twitter label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="social_twitter" runat="server" placeholder="Id de twitter" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end row -->
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <!-- bootstrap datepicker -->
    <script src="assets/libs/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>

    <script>
        function OpenFiledialog() {
            var vrnc = document.getElementById('<%= company_rnc.ClientID %>');
            if (vrnc.value.trim().length > 0) {
                document.getElementById('<%= FileUpload1.ClientID %>').click();
            }
        }

        function SaveImage() {
            document.getElementById('<%= btsaveimage.ClientID %>').click();
        }

        function OpenFiledialogStamp() {
            var vrnc = document.getElementById('<%= company_rnc.ClientID %>');
            if (vrnc.value.trim().length > 0) {
                document.getElementById('<%= FileUpload2.ClientID %>').click();
            }
        }

        function SaveImageStamp() {
            document.getElementById('<%= btsaveimage_stamp.ClientID %>').click();
        }
    </script>
</asp:Content>