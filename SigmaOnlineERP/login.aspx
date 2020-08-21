<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="SigmaOnlineERP.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Inisio de Sessión | Sigma ERP Online</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta content="ERP Web" name="description" />
    <meta content="Sigma Sistema de Gestión (https://www.sigma.net.do)" name="author" />
    <!-- App favicon -->
    <link rel="shortcut icon" href="assets/images/favicon.ico" />

    <!-- Bootstrap Css -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons Css -->
    <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <!-- App Css-->
    <link href="assets/css/app.min.css" rel="stylesheet" type="text/css" />

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
</head>
<body>
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

    <form id="form1" runat="server">
        <div class="account-pages my-5 pt-sm-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-8 col-lg-6 col-xl-5">
                        <div class="card overflow-hidden">
                            <div class="bg-soft-primary">
                                <div class="row">
                                    <div class="col-7">
                                        <div class="text-primary p-4">
                                            <h5 class="text-primary">Bienvenido !</h5>
                                            <p>Conéctate a Sigma ERP Online.</p>
                                        </div>
                                    </div>
                                    <div class="col-5 align-self-end">
                                        <img src="assets/images/profile-img.png" alt="" class="img-fluid" />
                                    </div>
                                </div>
                            </div>
                            <div class="card-body pt-0"> 
                                <div>
                                    <a href="https://www.sigma.net.do" target="_blank">
                                        <div class="avatar-md profile-user-wid mb-4">
                                            <span class="avatar-title rounded-circle bg-light">
                                                <img src="assets/images/SigmaERP_Icon5.jpg" alt="" class="rounded-circle" height="34" />
                                            </span>
                                        </div>
                                    </a>
                                </div>
                                <div class="p-2">
                                    <div role="form" class="form-horizontal">
        
                                        <div class="form-group">
                                            <label for="username">Usuario</label>
                                            <asp:TextBox ID="username" runat="server" placeholder="Introduce tu usuario" required autofocus
                                                oninvalid="this.setCustomValidity('Debes introducir un ID válido')"
                                                oninput="setCustomValidity('')"
                                                CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                        </div>
                
                                        <div class="form-group">
                                            <label for="userpassword">Contraseña</label>
                                            <asp:TextBox ID="userpassword" runat="server" TextMode="Password" CssClass="form-control" required
                                                oninvalid="this.setCustomValidity('Debes introducir tu Contraseña')"
                                                oninput="setCustomValidity('')"
                                                placeholder="Introduce tu conraseña" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                        </div>
                
                                        <div class="custom-control custom-checkbox">
                                            <input type="checkbox" class="custom-control-input" id="customControlInline" />
                                        </div>
                                        
                                        <div class="mt-3">
                                            <asp:Button ID="btnok" runat="server" Text="Iniciar sesión" CssClass="btn btn-primary btn-block waves-effect waves-light" OnClick="btnok_Click"
                                                OnClientClick="if (form.reportValidity()){setTimeout(function () {document.body.removeChild(modal);loading.style.display='none';}, 3000);ShowProgress();}" />
                                        </div>           

                                        <div class="mt-4 text-center">
                                            <h5 class="font-size-14 mb-3">Conéctate con</h5>
            
                                            <ul class="list-inline">
                                                <li class="list-inline-item">
                                                    <a href="javascript::void()" class="social-list-item bg-primary text-white border-primary">
                                                        <i class="mdi mdi-facebook"></i>
                                                    </a>
                                                </li>
                                                <li class="list-inline-item">
                                                    <a href="javascript::void()" class="social-list-item bg-info text-white border-info">
                                                        <i class="mdi mdi-twitter"></i>
                                                    </a>
                                                </li>
                                                <li class="list-inline-item">
                                                    <a href="javascript::void()" class="social-list-item bg-danger text-white border-danger">
                                                        <i class="mdi mdi-google"></i>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>

                                        <div class="mt-4 text-center">
                                            <a href="auth-recoverpw.html" class="text-muted"><i class="mdi mdi-lock mr-1"></i> Olvidé mi contraseña</a>
                                        </div>
                                    </div>
                                </div>            
                            </div>
                        </div>
                        <div class="mt-5 text-center">
                            <div>
                                <p>¿No estás registrado ? <a href="register.aspx" class="font-weight-medium text-primary"> Regístrate ahora </a> </p>
                                <p>© 2020 Sigma Sistemas de Gestión.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- JAVASCRIPT -->
    <script src="assets/libs/jquery/jquery.min.js"></script>
    <script src="assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/libs/metismenu/metisMenu.min.js"></script>
    <script src="assets/libs/simplebar/simplebar.min.js"></script>
    <script src="assets/libs/node-waves/waves.min.js"></script>

    <!-- App js -->
    <script src="assets/js/app.js"></script>

</body>
</html>
