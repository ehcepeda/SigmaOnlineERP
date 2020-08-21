<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSigma.Master" AutoEventWireup="true" CodeBehind="user-profile.aspx.cs" Inherits="SigmaOnlineERP.user_profile"
    MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            background-color: black;
            z-index: 99;
            opacity: 0.8;
            filter: alpha(opacity=80);
            -moz-opacity: 0.8;
            min-height: 100%;
            width: 100%;
        }
 
        .loading {
            font-family: Arial;
            font-size: 10pt;
            width: 200px;
            height: 100px;
            display: none;
            position: fixed;
            z-index: 999;
        }
    </style>

    <!-- Sweet Alerts js -->
    <script type="text/javascript" src="assets/js/sweetalert.min.js"></script>
    <link href="assets/js/sweetalert.min.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="assets/libs/jquery/jquery.min.js"></script>

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" LoadScriptsBeforeUI="true"></asp:ScriptManager>
    <div class="main-content">
        <div class="page-content">
            <div class="container-fluid">
                <!-- start page title -->
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box d-flex align-items-center justify-content-between">
                            <h4 class="mb-0 font-size-18">Mi perfil</h4>
                            <div class="page-title-right">
                                <ol class="breadcrumb m-0">
                                    <li class="breadcrumb-item"><a href="javascript: void(0);">Inicio</a></li>
                                    <li class="breadcrumb-item active">Perfil</li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end page title -->

                <div class="loading" align="center">
                    <img src="assets/images/loading_big.gif" alt="" />
                </div>
                <script type="text/javascript">
                    var modal, loading;
                    function ShowProgress() {
                        modal = document.createElement("DIV");
                        modal.className = "modal";
                        document.body.appendChild(modal);
                        loading = document.getElementsByClassName("loading")[0];
                        loading.style.display = "block";
                        var top = Math.max(window.innerHeight / 3 - loading.offsetHeight / 2, 0);
                        var left = Math.max(window.innerWidth / 2 - loading.offsetWidth / 2, 0);
                        loading.style.top = top + "px";
                        loading.style.left = left + "px";
                    };
                </script>

                <div class="row">
                    <div class="col-xl-4">
                        <div class="card overflow-hidden">
                            <div class="bg-soft-primary">
                                <div class="row">
                                    <div class="col-7">
                                        <div class="text-primary p-3">
                                            <h5 class="text-primary">Hola !</h5>
                                            <p>Agradecemos que nos acompañes</p>
                                        </div>
                                    </div>
                                    <div class="col-5 align-self-end">
                                        <img src="assets/images/profile-img.png" alt="" class="img-fluid" />
                                    </div>
                                </div>
                            </div>
                            <div class="card-body pt-0">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="avatar-md profile-user-wid mb-4">
                                            <asp:Button ID="btsaveimage" runat="server" Text="Button" Style="display: none;" OnClick="btsaveimage_Click" />
                                            <asp:FileUpload ID="FileUpload1" runat="server" Style="display: none;" onchange="SaveImage();" />
                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                <ContentTemplate>
                                                    <asp:ImageButton ID="img_profile" runat="server" class="img-thumbnail rounded-circle" alt="profile-image"
                                                        OnClientClick="OpenFiledialog();" CausesValidation="false" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                        <h5 class="font-size-15 text-truncate">
                                            <asp:Label ID="lbinfo_username" runat="server" Text=""></asp:Label></h5>
                                        <p class="text-muted mb-0 text-truncate">
                                            <asp:Label ID="lbinfo_email" runat="server" Text=""></asp:Label></p>
                                        <p class="text-muted mb-0 text-truncate">
                                            <asp:Label ID="lbinfo_rol" runat="server" Text=""></asp:Label></p>
                                    </div>

                                    <div class="col-sm-8">
                                        <div class="pt-4">

                                            <div class="row">
                                                <div class="col-4">
                                                    <h5 class="font-size-15">0</h5>
                                                    <p class="text-muted mb-0">Clientes</p>
                                                </div>
                                                <div class="col-4">
                                                    <h5 class="font-size-15">0</h5>
                                                    <p class="text-muted mb-0">Mensajes</p>
                                                </div>
                                                <div class="col-4">
                                                    <h5 class="font-size-15">$0.00</h5>
                                                    <p class="text-muted mb-0">Último pago</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end card -->
                    </div>

                    <div class="col-xl-8">
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="row mb-2">
                                                    <div class="col-sm-4">
                                                        <div class="search-box mr-2 mb-2 d-inline-block">
                                                            <div class="position-relative">
                                                                <h4 class="card-title">Informaciones generales</h4>
                                                                <p class="card-title-desc">verifica y actualiza tus datos, contraseña y redes sociales.</p>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-8">
                                                        <div class="text-sm-right">
                                                            <asp:LinkButton ID="btn_save_info" CssClass="btn btn-info waves-effect btn-label waves-light" runat="server"
                                                                OnClick="btn_save_info_Click"
                                                                OnClientClick="setTimeout(function () {document.body.removeChild(modal);loading.style.display='none';}, 3000);ShowProgress();">
                                                                <i class="fas fa-save label-icon"></i> Grabar
                                                            </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Nav tabs -->
                                                <ul id="myTabs" class="nav nav-tabs nav-tabs-custom nav-justified" role="tablist">
                                                    <li class="nav-item">
                                                        <a class="nav-link active" data-toggle="tab" href="#home1" role="tab" aria-controls="personal">
                                                            <span class="d-block d-sm-none"><i class="fas fa-user"></i></span>
                                                            <span class="d-none d-sm-block">Personales</span>
                                                        </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link" data-toggle="tab" href="#social1" role="tab" aria-controls="social">
                                                            <span class="d-block d-sm-none"><i class="far fa-thumbs-up"></i></span>
                                                            <span class="d-none d-sm-block">Redes sociales</span>
                                                        </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link" data-toggle="tab" href="#messages1" role="tab" aria-controls="messaages">
                                                            <span class="d-block d-sm-none"><i class="far fa-envelope"></i></span>
                                                            <span class="d-none d-sm-block">Mensajes</span>
                                                        </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link" data-toggle="tab" href="#settings1" role="tab" aria-controls="config">
                                                            <span class="d-block d-sm-none"><i class="fas fa-cog"></i></span>
                                                            <span class="d-none d-sm-block">Configuración</span>
                                                        </a>
                                                    </li>
                                                </ul>

                                                <!-- Tab panes -->
                                                <div class="tab-content p-3 text-muted">
                                                    <div class="tab-pane active" id="home1" role="tabpanel">
                                                        <div role="form">
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="name">Nombre completo</label>
                                                                    <div class="input-group mb-2 mr-sm-3">
                                                                        <div class="input-group-prepend">
                                                                            <div class="input-group-text"><i class="bx bx-user label-icon"></i></div>
                                                                        </div>
                                                                        <asp:TextBox ID="name" runat="server" CssClass="form-control" AutoCompleteType="Disabled"
                                                                            autocomplete="new-password"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="primaryphone">Teléfono</label>
                                                                    <div class="input-group mb-2 mr-sm-3">
                                                                        <div class="input-group-prepend">
                                                                            <div class="input-group-text"><i class="bx bx-phone label-icon"></i></div>
                                                                        </div>
                                                                        <asp:TextBox ID="primaryphone" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="secundaryphone">Celular</label>
                                                                    <div class="input-group mb-2 mr-sm-3">
                                                                        <div class="input-group-prepend">
                                                                            <div class="input-group-text"><i class="bx bx-mobile label-icon"></i></div>
                                                                        </div>
                                                                        <asp:TextBox ID="secundaryphone" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="cbfdn">Fecha de nacimiento</label>
                                                                    <div class="input-group mb-2 mr-sm-3">
                                                                        <div class="input-group-prepend">
                                                                            <div class="input-group-text"><i class="bx bx-calendar label-icon"></i></div>
                                                                        </div>
                                                                        <asp:TextBox ID="cbfdn" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="tab-pane" id="social1" role="tabpanel">
                                                        <div role="form">
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label for="social_facebook">Facebook</label>
                                                                    <div class="input-group mb-2 mr-sm-3">
                                                                        <div class="input-group-prepend">
                                                                            <div class="input-group-text"><i class="bx bxl-facebook label-icon"></i></div>
                                                                        </div>
                                                                        <asp:TextBox ID="social_facebook" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label for="social_instagram">Instagram</label>
                                                                    <div class="input-group mb-2 mr-sm-3">
                                                                        <div class="input-group-prepend">
                                                                            <div class="input-group-text"><i class="bx bxl-instagram label-icon"></i></div>
                                                                        </div>
                                                                        <asp:TextBox ID="social_instagram" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label for="social_twitter">Twitter</label>
                                                                    <div class="input-group mb-2 mr-sm-3">
                                                                        <div class="input-group-prepend">
                                                                            <div class="input-group-text"><i class="bx bxl-twitter label-icon"></i></div>
                                                                        </div>
                                                                        <asp:TextBox ID="social_twitter" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="tab-pane" id="messages1" role="tabpanel">
                                                        <p class="mb-0">
                                                            Etsy mixtape wayfarers, ethical wes anderson tofu before they
                                                            sold out mcsweeney's organic lomo retro fanny pack lo-fi
                                                            farm-to-table readymade. Messenger bag gentrify pitchfork
                                                            tattooed craft beer, iphone skateboard locavore carles etsy
                                                            salvia banksy hoodie helvetica. DIY synth PBR banksy irony.
                                                            Leggings gentrify squid 8-bit cred pitchfork. Williamsburg banh
                                                            mi whatever gluten-free carles.
                                                        </p>
                                                    </div>
                                                    <div class="tab-pane" id="settings1" role="tabpanel">
                                                        <div role="form">
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="cblanguage">Idioma</label>
                                                                    <asp:DropDownList ID="cblanguage" runat="server" CssClass="form-control">
                                                                        <asp:ListItem Text="Español" Value="1" />
                                                                        <asp:ListItem Text="Inglés" Value="2" />
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="cbcurrency">Moneda para reportes</label>
                                                                    <asp:DropDownList ID="cbcurrency" runat="server" CssClass="form-control">
                                                                        <asp:ListItem Text="Pesos" Value="1" />
                                                                        <asp:ListItem Text="Dólares" Value="2" />
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="cbmessages">Envía mensajes</label>
                                                                    <asp:DropDownList ID="cbmessages" runat="server" CssClass="form-control">
                                                                        <asp:ListItem Text="Si" Value="1" />
                                                                        <asp:ListItem Text="No" Value="0" />
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <!-- end card -->
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-6">
                    <script>document.write(new Date().getFullYear())</script>
                    © Sigma Sistemas de Gestión
                </div>
                <div class="col-sm-6">
                    <div class="text-sm-right d-none d-sm-block">
                        Diseñado y Desarrollado por <a href="https://www.sigma.net.do" target="_blank">Sigma</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- bs custom file input plugin -->
    <script src="assets/libs/bs-custom-file-input/bs-custom-file-input.min.js"></script>

    <script>
        function OpenFiledialog() {
            document.getElementById('<%= FileUpload1.ClientID %>').click();
        }

        function SaveImage() {
            document.getElementById('<%= btsaveimage.ClientID %>').click();
        }
    </script>
</asp:Content>
