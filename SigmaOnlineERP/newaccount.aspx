<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSigma.Master" AutoEventWireup="true" CodeBehind="newaccount.aspx.cs" Inherits="SigmaOnlineERP.newaccount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="assets/libs/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet">
    <script type="text/javascript" src="assets/libs/jquery/jquery.min.js"></script>

    <!-- Sweet Alerts js -->
    <script type="text/javascript" src="assets/js/sweetalert.min.js"></script>
    <link href="assets/js/sweetalert.min.css" rel="stylesheet" type="text/css" />

    <style>
        .table-normal td{
            padding: .40rem;
            vertical-align: middle;
            font-size: 12px;
            font-family: Arial;
        }

        .table-normal th{
            vertical-align: middle;
        }

        .modal {
            top: 0;
            left: 0;
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

        table tr:first-child th {
            background: #ffffff;
            background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2ZmZmZmZiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjMwJSIgc3RvcC1jb2xvcj0iI2Y2ZjZmNiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjMwJSIgc3RvcC1jb2xvcj0iI2Y2ZjZmNiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiNlNWU1ZTUiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
            background: -moz-linear-gradient(top, #ffffff 0%, #f6f6f6 30%, #f6f6f6 30%, #e5e5e5 100%);
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#ffffff), color-stop(30%,#f6f6f6), color-stop(30%,#f6f6f6), color-stop(100%,#e5e5e5));
            background: -webkit-linear-gradient(top, #ffffff 0%,#f6f6f6 30%,#f6f6f6 30%,#e5e5e5 100%);
            background: -o-linear-gradient(top, #ffffff 0%,#f6f6f6 30%,#f6f6f6 30%,#e5e5e5 100%);
            background: -ms-linear-gradient(top, #ffffff 0%,#f6f6f6 30%,#f6f6f6 30%,#e5e5e5 100%);
            background: linear-gradient(to bottom, #ffffff 0%,#f6f6f6 30%,#f6f6f6 30%,#e5e5e5 100%);
            filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#e5e5e5',GradientType=0 );
            padding: 8px 10px;
            color: #000;
            border-top: 1px solid #cecece;
            border-bottom: 1px solid #E6E6E6;
        }
    </style>

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" LoadScriptsBeforeUI="true"></asp:ScriptManager>
    <div class="main-content">
        <div class="page-content">
            <div class="container-fluid">
                <!-- start page title -->
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box d-flex align-items-center justify-content-between">
                            <h4 class="mb-0 font-size-18">Catálogo de cuenta</h4>
                            <div class="page-title-right">
                                <ol class="breadcrumb m-0">
                                    <li class="breadcrumb-item"><a href="accoounts.aspx">Catálogo</a></li>
                                    <li class="breadcrumb-item active">Cuenta</li>
                                </ol>
                            </div>
                        </div>  
                    </div>
                </div>
                <!-- end page title -->

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row mb-2">
                                            <div class="col-sm-4">
                                                <h4 class="card-title mb-4">Datos de la cuenta</h4>
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
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="accountid">Cuenta</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-id-card label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="accountid" runat="server" placeholder="Cuenta" CssClass="form-control" required
                                                                oninvalid="this.setCustomValidity('Debes introducir el número de la Cuenta')" MaxLength="15"
                                                                oninput="setCustomValidity('')"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="name">Nombre o descripción</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-text label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="name" runat="server" placeholder="Nombre de la cuenta" CssClass="form-control" MaxLength="100"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="cbtype">Tipo de cuenta</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-down-arrow label-icon"></i></div>
                                                            </div>
                                                            <asp:DropDownList ID="cbtype" runat="server" CssClass="form-control" AutoPostBack="true"
                                                                OnSelectedIndexChanged="cbtype_SelectedIndexChanged">
                                                                <asp:ListItem Value="AC" Text="Activo" />
                                                                <asp:ListItem Value="PA" Text="Pasivo" />
                                                                <asp:ListItem Value="CA" Text="Capital" />
                                                                <asp:ListItem Value="IN" Text="Ingreso" />
                                                                <asp:ListItem Value="CO" Text="Costo" />
                                                                <asp:ListItem Value="GA" Text="Gasto" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="cborigin">Tipo de cuenta</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-down-arrow label-icon"></i></div>
                                                            </div>
                                                            <asp:DropDownList ID="cborigin" runat="server" CssClass="form-control">
                                                                <asp:ListItem Value="D" Text="Débito" />
                                                                <asp:ListItem Value="C" Text="Crédito" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="cbcontrol">Cuenta control</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-id-card label-icon"></i></div>
                                                            </div>
                                                            <asp:DropDownList ID="cbcontrol" runat="server" CssClass="form-control" DataValueField="accountid"
                                                                DataTextField="name" AutoPostBack="true" OnSelectedIndexChanged="cbcontrol_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="cbdetail">¿Acepta movimientos?</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-id-arrow label-icon"></i></div>
                                                            </div>
                                                            <asp:DropDownList ID="cbdetail" runat="server" CssClass="form-control" AutoPostBack="true"
                                                                OnSelectedIndexChanged="cbdetail_SelectedIndexChanged">
                                                                <asp:ListItem Value="1" Text="Si" />
                                                                <asp:ListItem Value="0" Text="No" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="cbstate">Estatus</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-id-arrow label-icon"></i></div>
                                                            </div>
                                                            <asp:DropDownList ID="cbstate" runat="server" CssClass="form-control">
                                                                <asp:ListItem Value="1" Text="Activa" />
                                                                <asp:ListItem Value="0" Text="Inactiva" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="cbdirect">¿Entrada directa?</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-id-arrow label-icon"></i></div>
                                                            </div>
                                                            <asp:DropDownList ID="cbdirect" runat="server" CssClass="form-control">
                                                                <asp:ListItem Value="1" Text="Si" />
                                                                <asp:ListItem Value="0" Text="No" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h2 class="card-title">Últimas 5 cuentas creadas</h2>
                                        <p class="card-title-desc">
                                        </p>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="table-responsive mb-0" data-pattern="priority-columns">
                                                    <asp:GridView ID="gvaccounts" runat="server" CssClass="table table-normal mb-0 table-bordered"
                                                        AutoGenerateColumns="false" AllowPaging="false" PageSize="50" GridLines="Vertical" Font-Size="Smaller"
                                                        DataKeyNames="accountid" ShowFooter="false">
                                                        <Columns>
                                                            <asp:BoundField DataField="accountid" HeaderText="CUENTA" ItemStyle-Width="110" HeaderStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField DataField="name" HeaderText="NOMBRE DE LA CUENTA" ItemStyle-Width="320" HeaderStyle-HorizontalAlign="Center" />
                                                            <asp:BoundField DataField="account_type" HeaderText="TYPO" />
                                                            <asp:BoundField DataField="origin" HeaderText="Origen" />
                                                        </Columns>
                                                        <PagerSettings Visible="true" />
                                                    </asp:GridView>
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
</asp:Content>