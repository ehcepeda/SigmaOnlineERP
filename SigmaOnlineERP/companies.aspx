<%@ Page Title="SigmaWeb - Empresas" Language="C#" MasterPageFile="~/SiteSigma.Master" AutoEventWireup="true" CodeBehind="companies.aspx.cs" Inherits="SigmaOnlineERP.companies"
    MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .table-normal td{
            padding: .40rem;
            vertical-align: middle;
            font-size: 12px;
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

    <!-- Sweet Alerts js -->
    <script type="text/javascript" src="assets/js/sweetalert.min.js"></script>
    <link href="assets/js/sweetalert.min.css" rel="stylesheet" type="text/css" />

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
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
                                    <li class="breadcrumb-item"><a href="default.aspx">Inicio</a></li>
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
                                                <div class="col-sm-10">
                                                    <ul class="list-inline user-chat-nav mb-0">
                                                        <div class="d-inline-block">
                                                            <div class="position-relative">
                                                                <asp:TextBox ID="tbsearch" CssClass="form-control" runat="server" placeholder="Buscar..." 
                                                                    AutoCompleteType="Disabled"></asp:TextBox>
                                                                <div class="chat-input-links">
                                                                    <ul class="list-inline mb-0">
                                                                        <li class="list-inline-item">
                                                                            <asp:LinkButton ID="btn_search" runat="server" OnClick="btn_search_Click">
                                                                                <i class="mdi mdi-magnify"></i>
                                                                            </asp:LinkButton>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </ul>
                                                </div>
                                                <div class="col-sm-2">
                                                    <div class="text-sm-right">
                                                        <asp:LinkButton ID="btn_add" CssClass="btn btn-success waves-effect btn-label waves-light" runat="server"
                                                            OnClick="btn_add_Click">
                                                            <i class="bx bx-plus label-icon"></i> Nueva empresa
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="table-responsive mb-0" data-pattern="priority-columns">
                                                <asp:GridView ID="gvcompanies" runat="server" CssClass="table table-normal mb-0 table-bordered"
                                                    AutoGenerateColumns="false" AllowPaging="true" PageSize="50" GridLines="Vertical" Font-Size="Smaller"
                                                    DataKeyNames="companyid" ShowFooter="true" OnRowCommand="gvcompanies_RowCommand">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Acción" ItemStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-Wrap="false">
                                                            <ItemTemplate>
                                                                <div style="text-align: center;" runat="server" visible='<%# Eval("companyid").ToString().Length > 0 %>'>
                                                                    <asp:LinkButton ID="lkedit" runat="server" CssClass="btn btn-outline-info btn-sm" CommandArgument='<%# Eval("companyid").ToString() %>'
                                                                        CommandName="edit" CausesValidation="false"
                                                                        data-toggle="tooltip" data-placement="top" title="Modificar datos"
                                                                        Visible='<%# Eval("isenabled").ToString() == "1" %>'><i class="mdi mdi-pencil font-size-18"></i></asp:LinkButton>

                                                                    <asp:LinkButton ID="lkcancel" runat="server" CssClass="btn btn-outline-danger btn-sm" CommandArgument='<%# Eval("companyid").ToString() %>'
                                                                        CommandName="inactivate" Visible='<%# Eval("isenabled").ToString() == "1" %>' CausesValidation="false"
                                                                        data-toggle="tooltip" data-placement="top" title="Inactivar empresa">
                                                                        <i class="mdi mdi-cancel font-size-18"></i>
                                                                    </asp:LinkButton>

                                                                    <asp:LinkButton ID="lkactive" runat="server" CssClass="btn btn-outline-success btn-sm" CommandArgument='<%# Eval("companyid").ToString() %>'
                                                                        CommandName="reactivate" Visible='<%# Eval("isenabled").ToString() == "0" %>' CausesValidation="false"
                                                                        data-toggle="tooltip" data-placement="top" title="Activar empresa">
                                                                        <i class="mdi mdi-check font-size-18"></i>
                                                                    </asp:LinkButton>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="companyid" HeaderText="ID" ItemStyle-Width="70" HeaderStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="rnc" HeaderText="RNC" ItemStyle-Width="120" HeaderStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="razon_social" HeaderText="Razón social" FooterStyle-Font-Bold="true" />
                                                        <asp:BoundField DataField="name" HeaderText="Nombre comercial" FooterStyle-Font-Bold="true" />
                                                        <asp:BoundField DataField="state" HeaderText="Estado" FooterStyle-Font-Bold="true" />
                                                        <asp:BoundField DataField="city" HeaderText="Ciudad" FooterStyle-Font-Bold="true" />
                                                        <asp:BoundField DataField="phone1" HeaderText="Teléfono 1" FooterStyle-Font-Bold="true" ItemStyle-Width="130" />
                                                        <asp:BoundField DataField="phone2" HeaderText="Teléfono 2" FooterStyle-Font-Bold="true" ItemStyle-Width="130" />
                                                        <asp:TemplateField ItemStyle-VerticalAlign="Middle" ItemStyle-Width="30" ItemStyle-HorizontalAlign="Center" HeaderText="Estatus">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbestatus" runat="server" Text='<%# Eval("isenabled").ToString() == "1" ? "Activa" : "Inactiva" %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <PagerSettings Visible="true" />
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
                        <asp:PostBackTrigger ControlID="gvcompanies" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <!-- Footer Start -->
    <%
        Response.WriteFile("assets/footer.html");
    %>
    <!-- end Footer -->

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
