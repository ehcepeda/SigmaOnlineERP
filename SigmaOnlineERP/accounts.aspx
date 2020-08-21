<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSigma.Master" AutoEventWireup="true" CodeBehind="accounts.aspx.cs" Inherits="SigmaOnlineERP.accounts"
    EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

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

    <div class="main-content">
        <div class="page-content">
            <div class="container-fluid">
                <!-- start page title -->
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box d-flex align-items-center justify-content-between">
                            <h4 class="mb-0 font-size-18">Empresas</h4>
                            <div class="page-title-right">
                                <ol class="breadcrumb m-0">
                                    <li class="breadcrumb-item"><a href="javascript: void(0);">Inicio</a></li>
                                    <li class="breadcrumb-item active">Empresas</li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end page title -->

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="table-rep-plugin">
                                            <div class="row mb-2">
                                                <div class="btn-toolbar col-sm-8">
                                                    <div class="button-items mb-0">
                                                        <asp:LinkButton ID="btn_add" CssClass="btn btn-success waves-effect btn-label waves-light" runat="server"
                                                            OnClick="btn_add_Click">
                                                            <i class="bx bx-plus label-icon"></i> Nueva cuenta
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btn_refresh" CssClass="btn btn-outline-success waves-effect btn-label waves-light" runat="server">
                                                            <i class="bx bx-loader label-icon"></i> Refrescar
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="btn_export" CssClass="btn btn-outline-dark waves-effect btn-label waves-light" runat="server"
                                                            OnClick="btn_export_Click"
                                                            OnClientClick="setTimeout(function () {document.body.removeChild(modal);loading.style.display='none';}, 2000);ShowProgress()">
                                                            <i class="bx bx-printer label-icon"></i> Imprimir
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                                <div class="col-sm-4 text-sm-righ">
                                                    <div class="input-group mb-2 mr-sm-3">
                                                        <div class="input-group-prepend">
                                                            <div class="input-group-text"><i class="bx bx-search label-icon"></i></div>
                                                        </div>
                                                        <asp:TextBox ID="tbsearch" CssClass="form-control" runat="server" placeholder="Texto a buscar..."></asp:TextBox>
                                                        <div class="input-group-prepend">
                                                            <div class="input-group-text">
                                                                <asp:LinkButton ID="btn_search" runat="server" OnClick="btn_search_Click">
                                                                    Buscar
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="table-responsive mb-0" data-pattern="priority-columns">
                                                <asp:GridView ID="gvaccounts" runat="server" CssClass="table table-normal mb-0 table-bordered" 
                                                    AutoGenerateColumns="false" AllowPaging="true" PageSize="40" GridLines="Vertical" Font-Size="Smaller"
                                                    DataKeyNames="accountid" ShowFooter="false" OnPageIndexChanging="gvaccounts_PageIndexChanging"
                                                    OnRowCommand="gvaccounts_RowCommand" OnRowDataBound="gvaccounts_RowDataBound">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Acción" ItemStyle-Width="110" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                                            <ItemTemplate>
                                                                <div style="text-align: center;" runat="server" visible='<%# Eval("accountid").ToString().Length > 0 %>'>
                                                                    <asp:LinkButton ID="lkedit" runat="server" CssClass="btn btn-outline-info btn-sm" 
                                                                        CommandArgument='<%# Eval("accountid").ToString() %>' CommandName="edit" AlternateText="Modifcar datos" 
                                                                        CausesValidation="false"><i class="mdi mdi-pencil font-size-12"></i></asp:LinkButton>

                                                                    <asp:LinkButton ID="lkcancel" runat="server" CssClass="btn btn-outline-danger btn-sm" 
                                                                        CommandArgument='<%# Eval("accountid").ToString() %>'
                                                                        CommandName="inactivate" Visible='<%# Eval("isenabled").ToString() == "1" %>' CausesValidation="false"
                                                                        AlternateText="Inactivar"><i class="mdi mdi-cancel font-size-12"></i>
                                                                    </asp:LinkButton>

                                                                    <asp:LinkButton ID="lkactive" runat="server" CssClass="btn btn-outline-success btn-sm" 
                                                                        CommandArgument='<%# Eval("accountid").ToString() %>'
                                                                        CommandName="reactivate" Visible='<%# Eval("isenabled").ToString() == "0" %>' CausesValidation="false"
                                                                        AlternateText="activar"><i class="mdi mdi-check font-size-12"></i>
                                                                    </asp:LinkButton>

                                                                    <asp:LinkButton ID="lkdelete" runat="server" CssClass="btn btn-outline-danger btn-sm" 
                                                                        CommandArgument='<%# Eval("accountid").ToString() %>'
                                                                        CommandName="erase" CausesValidation="false" AlternateText="Eliminar">
                                                                        <i class="mdi mdi-trash-can font-size-12"></i>
                                                                    </asp:LinkButton>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="accountid" HeaderText="Cuenta" ItemStyle-Width="120" HeaderStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="name" HeaderText="Nombre de la cuenta" ItemStyle-Width="280" HeaderStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="account_type" HeaderText="Tipo" ItemStyle-Width="110" />
                                                        <asp:BoundField DataField="origin" HeaderText="Origen" ItemStyle-Width="110" />
                                                        <asp:BoundField DataField="controlid" HeaderText="Control" ItemStyle-Width="110" />
                                                        <asp:TemplateField ItemStyle-VerticalAlign="Middle" ItemStyle-Width="30" ItemStyle-HorizontalAlign="Center" HeaderText="¿Detalle?">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbisdetail" runat="server" Text='<%# Eval("isdetail").ToString() == "1" ? "Si" : "No" %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-VerticalAlign="Middle" ItemStyle-Width="30" ItemStyle-HorizontalAlign="Center" HeaderText="¿Directa?">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbdirect" runat="server" Text='<%# Eval("direct").ToString() == "1" ? "Si" : "No" %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-VerticalAlign="Middle" ItemStyle-Width="30" ItemStyle-HorizontalAlign="Center" HeaderText="Estatus">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbestatus" runat="server" Text='<%# Eval("isenabled").ToString() == "1" ? "Activa" : "Inactiva" %>'
                                                                    ForeColor='<%# Eval("isenabled").ToString() == "1" ? System.Drawing.Color.FromName("#495057") : System.Drawing.Color.Red %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="create_date" HeaderText="Fecha creación" ItemStyle-Width="110" />
                                                    </Columns>
                                                    <PagerSettings Visible="true" />
                                                    <PagerStyle CssClass="pagination-lg" />
                                                </asp:GridView>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- end col -->
                        </div>
                        <!-- end row -->
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="btn_export" />
                        <asp:PostBackTrigger ControlID="btn_refresh" />
                        <asp:PostBackTrigger ControlID="gvaccounts" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-6">
                    <script>document.write(new Date().getFullYear())</script>
                    © Skote.
                </div>
                <div class="col-sm-6">
                    <div class="text-sm-right d-none d-sm-block">
                        Design & Develop by Themesbrand
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <script src="assets/libs/pdfmake/build/pdfmake.min.js"></script>
    <script src="assets/libs/pdfmake/build/vfs_fonts.js"></script>

    <script type="text/javascript">
        function Confirm(ctl, event) {
            event.preventDefault();
            swal({
                title: "Inactivar",
                text: "¿Seguro que quieres Inactivar esta Empresa?",
                type: "warning",
                showCancelButton: true,
                closeOnConfirm: true,
                closeOnCancel: true
            },
                function (isConfirm) {
                    if (isConfirm) {
                        return true;
                    } else {
                        return false;
                    }
                });
        }

        function ConfirmActivate(ctl, event) {
            event.preventDefault();
            swal({
                title: "Activar",
                text: "¿Seguro que quieres Activar esta Empresa?, esto conlleva un cargo mensual.",
                type: "warning",
                showCancelButton: true,
                closeOnConfirm: true,
                closeOnCancel: true
            },
                function (isConfirm) {
                    if (isConfirm) {
                        return true;
                    } else {
                        return false;
                    }
                });
        }
    </script>
</asp:Content>
