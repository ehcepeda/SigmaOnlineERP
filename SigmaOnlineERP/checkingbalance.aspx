<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSigma.Master" AutoEventWireup="true" CodeBehind="checkingbalance.aspx.cs" Inherits="SigmaOnlineERP.checkingbalance"
    EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="assets/libs/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="assets/libs/@chenfengyuan/datepicker/datepicker.min.css">

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

        .table-normal-header-number th{
            vertical-align: middle;
            text-align: right;
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

    <div class="main-content">
        <div class="page-content">
            <div class="container-fluid">
                <!-- start page title -->
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box d-flex align-items-center justify-content-between">
                            <h4 class="mb-0 font-size-18">Balance de Comprobación</h4>
                            <div class="page-title-right">
                                <ol class="breadcrumb m-0">
                                    <li class="breadcrumb-item"><a href="default.aspx">Inicio</a></li>
                                    <li class="breadcrumb-item active">Balance de Comprobación</li>
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
                                        <div class="row">
                                            <div class="col-sm-8">
                                                <ul class="list-inline user-chat-nav mb-0">
                                                    <div class="btn-group">
                                                        <div class="input-group">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-calendar label-icon"></i></div>
                                                            </div>
                                                            <asp:DropDownList ID="cbyear" runat="server" CssClass="form-control" OnSelectedIndexChanged="cbyear_SelectedIndexChanged"
                                                                AutoPostBack="true">
                                                                <asp:ListItem Value="2019" Text="2019" />
                                                                <asp:ListItem Value="2020" Text="2020" />
                                                                <asp:ListItem Value="2021" Text="2021" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="btn-group">
                                                        <asp:LinkButton ID="btn_refresh" runat="server" CssClass="btn btn-outline-info waves-effect waves-light"
                                                            data-toggle="tooltip" data-placement="top" title="Refrescar" OnClick="btn_refresh_Click">
                                                            <i class="bx bx-repost"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                    <div class="btn-group">
                                                        <asp:LinkButton ID="btn_export" runat="server" CssClass="btn btn-outline-info waves-effect waves-light"
                                                            data-toggle="tooltip" data-placement="top" title="Imprimir listado"  OnClick="btn_export_Click">
                                                            <i class="bx bx-printer"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                </ul>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="alert alert-warning mb-0" role="alert">
                                                    Puedes dar un click en el monto de las cuentas para ver el detalle!
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="table-rep-plugin">
                                            <div class="table-responsive mb-0" data-pattern="priority-columns">
                                                <asp:GridView ID="gvbalance" runat="server" CssClass="table table-normal mb-0 table-bordered" 
                                                    AutoGenerateColumns="false" AllowPaging="false" PageSize="40" GridLines="Vertical" Font-Size="Smaller"
                                                    DataKeyNames="accountid" ShowFooter="false" FooterStyle-Font-Bold="true"
                                                    OnRowDataBound="gvbalance_RowDataBound" OnRowCommand="gvbalance_RowCommand">
                                                    <Columns>
                                                        <asp:TemplateField Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbisdetail" runat="server" Text='<%# Eval("isdetail") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:BoundField DataField="accountid" HeaderText="Cuenta" ItemStyle-Width="110" />
                                                        <asp:BoundField DataField="name" HeaderText="Nombre de la cuenta" ItemStyle-Width="20%" />

                                                        <asp:TemplateField HeaderText="Ene" HeaderStyle-CssClass="text-right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="110">
                                                            <ItemTemplate>
                                                                <div class="dropdown float-right">
                                                                    <a href="#" class="dropdown-toggle arrow-none" data-toggle="dropdown" aria-expanded="false">
                                                                        <asp:Label ID="lbene" runat="server" Text='<%# Convert.ToDecimal(Eval("ene").ToString()).ToString("N2") %>'
                                                                             ForeColor='<%# (Eval("ene").ToString().Length > 0) ? 
                                                                                Eval("ene").ToString().Substring(0,1) == "-" ? System.Drawing.Color.Red : System.Drawing.Color.Black :
                                                                                System.Drawing.Color.Black %>'></asp:Label>
                                                                    </a>
                                                                    <div class="dropdown-menu dropdown-menu-right">
                                                                        <div runat="server" visible='<%# Eval("isdetail").ToString() == "1" %>'>
                                                                            <asp:LinkButton ID="lkene" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="ene">
                                                                                <i class="bx bx-detail font-size-16 align-middle mr-1 text-info"></i>
                                                                                Detalle de la cuenta
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="lkbal_ene" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="bal_ene">
                                                                                <i class="bx bx-dollar-circle font-size-16 align-middle mr-1 text-info"></i>
                                                                                Balance del mes
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Feb" HeaderStyle-CssClass="text-right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="110">
                                                            <ItemTemplate>
                                                                <div class="dropdown float-right">
                                                                    <a href="#" class="dropdown-toggle arrow-none" data-toggle="dropdown" aria-expanded="false">
                                                                        <asp:Label ID="lbfeb" runat="server" Text='<%# Convert.ToDecimal(Eval("feb").ToString()).ToString("N2") %>'
                                                                             ForeColor='<%# (Eval("feb").ToString().Length > 0) ? 
                                                                                Eval("feb").ToString().Substring(0,1) == "-" ? System.Drawing.Color.Red : System.Drawing.Color.Black :
                                                                                System.Drawing.Color.Black %>'></asp:Label>
                                                                    </a>
                                                                    <div class="dropdown-menu dropdown-menu-right">
                                                                        <div runat="server" visible='<%# Eval("isdetail").ToString() == "1" %>'>
                                                                            <asp:LinkButton ID="lkfeb" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="feb">
                                                                                <i class="bx bx-detail font-size-16 align-middle mr-1 text-info"></i>
                                                                                Detalle de la cuenta
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="lkbal_feb" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="bal_feb">
                                                                                <i class="bx bx-dollar-circle font-size-16 align-middle mr-1 text-info"></i>
                                                                                Balance del mes
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Mar" HeaderStyle-CssClass="text-right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="110">
                                                            <ItemTemplate>
                                                                <div class="dropdown float-right">
                                                                    <a href="#" class="dropdown-toggle arrow-none" data-toggle="dropdown" aria-expanded="false">
                                                                        <asp:Label ID="lbmar" runat="server" Text='<%# Convert.ToDecimal(Eval("mar").ToString()).ToString("N2") %>'
                                                                             ForeColor='<%# (Eval("mar").ToString().Length > 0) ? 
                                                                                Eval("mar").ToString().Substring(0,1) == "-" ? System.Drawing.Color.Red : System.Drawing.Color.Black :
                                                                                System.Drawing.Color.Black %>'></asp:Label>
                                                                    </a>
                                                                    <div class="dropdown-menu dropdown-menu-right">
                                                                        <div runat="server" visible='<%# Eval("isdetail").ToString() == "1" %>'>
                                                                            <asp:LinkButton ID="lkmar" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="mar">
                                                                                <i class="bx bx-detail font-size-16 align-middle mr-1 text-info"></i>
                                                                                Detalle de la cuenta
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="lkbal_mar" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="bal_mar">
                                                                                <i class="bx bx-dollar-circle font-size-16 align-middle mr-1 text-info"></i>
                                                                                Balance del mes
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Abr" HeaderStyle-CssClass="text-right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="110">
                                                            <ItemTemplate>
                                                                <div class="dropdown float-right">
                                                                    <a href="#" class="dropdown-toggle arrow-none" data-toggle="dropdown" aria-expanded="false">
                                                                        <asp:Label ID="lbabr" runat="server" Text='<%# Convert.ToDecimal(Eval("abr").ToString()).ToString("N2") %>'
                                                                             ForeColor='<%# (Eval("abr").ToString().Length > 0) ? 
                                                                                Eval("abr").ToString().Substring(0,1) == "-" ? System.Drawing.Color.Red : System.Drawing.Color.Black :
                                                                                System.Drawing.Color.Black %>'></asp:Label>
                                                                    </a>
                                                                    <div class="dropdown-menu dropdown-menu-right">
                                                                        <div runat="server" visible='<%# Eval("isdetail").ToString() == "1" %>'>
                                                                            <asp:LinkButton ID="lkabr" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="abr">
                                                                                <i class="bx bx-detail font-size-16 align-middle mr-1 text-info"></i>
                                                                                Detalle de la cuenta
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="lkbal_abr" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="bal_abr">
                                                                                <i class="bx bx-dollar-circle font-size-16 align-middle mr-1 text-info"></i>
                                                                                Balance del mes
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="May" HeaderStyle-CssClass="text-right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="110">
                                                            <ItemTemplate>
                                                                <div class="dropdown float-right">
                                                                    <a href="#" class="dropdown-toggle arrow-none" data-toggle="dropdown" aria-expanded="false">
                                                                        <asp:Label ID="lbmay" runat="server" Text='<%# Convert.ToDecimal(Eval("may").ToString()).ToString("N2") %>'
                                                                             ForeColor='<%# (Eval("may").ToString().Length > 0) ? 
                                                                                Eval("may").ToString().Substring(0,1) == "-" ? System.Drawing.Color.Red : System.Drawing.Color.Black :
                                                                                System.Drawing.Color.Black %>'></asp:Label>
                                                                    </a>
                                                                    <div class="dropdown-menu dropdown-menu-right">
                                                                        <div runat="server" visible='<%# Eval("isdetail").ToString() == "1" %>'>
                                                                            <asp:LinkButton ID="lkmay" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="may">
                                                                                <i class="bx bx-detail font-size-16 align-middle mr-1 text-info"></i>
                                                                                Detalle de la cuenta
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="lkbal_may" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="bal_may">
                                                                                <i class="bx bx-dollar-circle font-size-16 align-middle mr-1 text-info"></i>
                                                                                Balance del mes
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Jun" HeaderStyle-CssClass="text-right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="110">
                                                            <ItemTemplate>
                                                                <div class="dropdown float-right">
                                                                    <a href="#" class="dropdown-toggle arrow-none" data-toggle="dropdown" aria-expanded="false">
                                                                        <asp:Label ID="lbjun" runat="server" Text='<%# Convert.ToDecimal(Eval("jun").ToString()).ToString("N2") %>'
                                                                             ForeColor='<%# (Eval("jun").ToString().Length > 0) ? 
                                                                                Eval("jun").ToString().Substring(0,1) == "-" ? System.Drawing.Color.Red : System.Drawing.Color.Black :
                                                                                System.Drawing.Color.Black %>'></asp:Label>
                                                                    </a>
                                                                    <div class="dropdown-menu dropdown-menu-right">
                                                                        <div runat="server" visible='<%# Eval("isdetail").ToString() == "1" %>'>
                                                                            <asp:LinkButton ID="lkjun" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="jun">
                                                                                <i class="bx bx-detail font-size-16 align-middle mr-1 text-info"></i>
                                                                                Detalle de la cuenta
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="lkbal_jun" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="bal_jun">
                                                                                <i class="bx bx-dollar-circle font-size-16 align-middle mr-1 text-info"></i>
                                                                                Balance del mes
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Jul" HeaderStyle-CssClass="text-right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="110">
                                                            <ItemTemplate>
                                                                <div class="dropdown float-right">
                                                                    <a href="#" class="dropdown-toggle arrow-none" data-toggle="dropdown" aria-expanded="false">
                                                                        <asp:Label ID="lbjul" runat="server" Text='<%# Convert.ToDecimal(Eval("jul").ToString()).ToString("N2") %>'
                                                                             ForeColor='<%# (Eval("jul").ToString().Length > 0) ? 
                                                                                Eval("jul").ToString().Substring(0,1) == "-" ? System.Drawing.Color.Red : System.Drawing.Color.Black :
                                                                                System.Drawing.Color.Black %>'></asp:Label>
                                                                    </a>
                                                                    <div class="dropdown-menu dropdown-menu-right">
                                                                        <div runat="server" visible='<%# Eval("isdetail").ToString() == "1" %>'>
                                                                            <asp:LinkButton ID="lkjul" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="jul">
                                                                                <i class="bx bx-detail font-size-16 align-middle mr-1 text-info"></i>
                                                                                Detalle de la cuenta
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="lkbal_jul" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="bal_jul">
                                                                                <i class="bx bx-dollar-circle font-size-16 align-middle mr-1 text-info"></i>
                                                                                Balance del mes
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Ago" HeaderStyle-CssClass="text-right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="110">
                                                            <ItemTemplate>
                                                                <div class="dropdown float-right">
                                                                    <a href="#" class="dropdown-toggle arrow-none" data-toggle="dropdown" aria-expanded="false">
                                                                        <asp:Label ID="lbago" runat="server" Text='<%# Convert.ToDecimal(Eval("ago").ToString()).ToString("N2") %>'
                                                                             ForeColor='<%# (Eval("ago").ToString().Length > 0) ? 
                                                                                Eval("ago").ToString().Substring(0,1) == "-" ? System.Drawing.Color.Red : System.Drawing.Color.Black :
                                                                                System.Drawing.Color.Black %>'></asp:Label>
                                                                    </a>
                                                                    <div class="dropdown-menu dropdown-menu-right">
                                                                        <div runat="server" visible='<%# Eval("isdetail").ToString() == "1" %>'>
                                                                            <asp:LinkButton ID="lkago" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="ago">
                                                                                <i class="bx bx-detail font-size-16 align-middle mr-1 text-info"></i>
                                                                                Detalle de la cuenta
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="lkbal_ago" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="bal_ago">
                                                                                <i class="bx bx-dollar-circle font-size-16 align-middle mr-1 text-info"></i>
                                                                                Balance del mes
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Sep" HeaderStyle-CssClass="text-right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="110">
                                                            <ItemTemplate>
                                                                <div class="dropdown float-right">
                                                                    <a href="#" class="dropdown-toggle arrow-none" data-toggle="dropdown" aria-expanded="false">
                                                                        <asp:Label ID="lbsep" runat="server" Text='<%# Convert.ToDecimal(Eval("sep").ToString()).ToString("N2") %>'
                                                                             ForeColor='<%# (Eval("sep").ToString().Length > 0) ? 
                                                                                Eval("sep").ToString().Substring(0,1) == "-" ? System.Drawing.Color.Red : System.Drawing.Color.Black :
                                                                                System.Drawing.Color.Black %>'></asp:Label>
                                                                    </a>
                                                                    <div class="dropdown-menu dropdown-menu-right">
                                                                        <div runat="server" visible='<%# Eval("isdetail").ToString() == "1" %>'>
                                                                            <asp:LinkButton ID="lksep" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="sep">
                                                                                <i class="bx bx-detail font-size-16 align-middle mr-1 text-info"></i>
                                                                                Detalle de la cuenta
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="lkbal_sep" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="bal_sep">
                                                                                <i class="bx bx-dollar-circle font-size-16 align-middle mr-1 text-info"></i>
                                                                                Balance del mes
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Oct" HeaderStyle-CssClass="text-right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="110">
                                                            <ItemTemplate>
                                                                <div class="dropdown float-right">
                                                                    <a href="#" class="dropdown-toggle arrow-none" data-toggle="dropdown" aria-expanded="false">
                                                                        <asp:Label ID="lboct" runat="server" Text='<%# Convert.ToDecimal(Eval("oct").ToString()).ToString("N2") %>'
                                                                             ForeColor='<%# (Eval("oct").ToString().Length > 0) ? 
                                                                                Eval("oct").ToString().Substring(0,1) == "-" ? System.Drawing.Color.Red : System.Drawing.Color.Black :
                                                                                System.Drawing.Color.Black %>'></asp:Label>
                                                                    </a>
                                                                    <div class="dropdown-menu dropdown-menu-right">
                                                                        <div runat="server" visible='<%# Eval("isdetail").ToString() == "1" %>'>
                                                                            <asp:LinkButton ID="lkoct" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="oct">
                                                                                <i class="bx bx-detail font-size-16 align-middle mr-1 text-info"></i>
                                                                                Detalle de la cuenta
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="lkbal_oct" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="bal_oct">
                                                                                <i class="bx bx-dollar-circle font-size-16 align-middle mr-1 text-info"></i>
                                                                                Balance del mes
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Nov" HeaderStyle-CssClass="text-right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="110">
                                                            <ItemTemplate>
                                                                <div class="dropdown float-right">
                                                                    <a href="#" class="dropdown-toggle arrow-none" data-toggle="dropdown" aria-expanded="false">
                                                                        <asp:Label ID="lbnov" runat="server" Text='<%# Convert.ToDecimal(Eval("nov").ToString()).ToString("N2") %>'
                                                                             ForeColor='<%# (Eval("nov").ToString().Length > 0) ? 
                                                                                Eval("nov").ToString().Substring(0,1) == "-" ? System.Drawing.Color.Red : System.Drawing.Color.Black :
                                                                                System.Drawing.Color.Black %>'></asp:Label>
                                                                    </a>
                                                                    <div class="dropdown-menu dropdown-menu-right">
                                                                        <div runat="server" visible='<%# Eval("isdetail").ToString() == "1" %>'>
                                                                            <asp:LinkButton ID="lknov" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="nov">
                                                                                <i class="bx bx-detail font-size-16 align-middle mr-1 text-info"></i>
                                                                                Detalle de la cuenta
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="lkbal_nov" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="bal_nov">
                                                                                <i class="bx bx-dollar-circle font-size-16 align-middle mr-1 text-info"></i>
                                                                                Balance del mes
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Dic" HeaderStyle-CssClass="text-right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="110">
                                                            <ItemTemplate>
                                                                <div class="dropdown float-right">
                                                                    <a href="#" class="dropdown-toggle arrow-none" data-toggle="dropdown" aria-expanded="false">
                                                                        <asp:Label ID="lbdic" runat="server" Text='<%# Convert.ToDecimal(Eval("dic").ToString()).ToString("N2") %>'
                                                                             ForeColor='<%# (Eval("dic").ToString().Length > 0) ? 
                                                                                Eval("dic").ToString().Substring(0,1) == "-" ? System.Drawing.Color.Red : System.Drawing.Color.Black :
                                                                                System.Drawing.Color.Black %>'></asp:Label>
                                                                    </a>
                                                                    <div class="dropdown-menu dropdown-menu-right">
                                                                        <div runat="server" visible='<%# Eval("isdetail").ToString() == "1" %>'>
                                                                            <asp:LinkButton ID="lkdic" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="dic">
                                                                                <i class="bx bx-detail font-size-16 align-middle mr-1 text-info"></i>
                                                                                Detalle de la cuenta
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="lkbal_dic" CssClass="dropdown-item" runat="server" CommandArgument='<%# Eval("accountid").ToString() %>' 
                                                                                CommandName="bal_dic">
                                                                                <i class="bx bx-dollar-circle font-size-16 align-middle mr-1 text-info"></i>
                                                                                Balance del mes
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:BoundField DataField="tot" ItemStyle-Width="110" HeaderText="Total" HeaderStyle-CssClass="text-right"                                                            
                                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:n}" />
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
                        <asp:PostBackTrigger ControlID="btn_refresh" />
                        <asp:PostBackTrigger ControlID="btn_export" />
                        <asp:AsyncPostBackTrigger ControlID="gvbalance" EventName="RowCommand" /> 
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>

        <!-- Footer Start -->
        <%
            Response.WriteFile("assets/footer.html");
        %>
        <!-- end Footer -->
    </div>

    <!-- modal content -->
    <div id="myModalDetail" class="modal fade bs-example-modal-center" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
            <div class="modal-content" style="width: 1350px;">
                <div class="modal-header">
                    <h5 class="modal-title mt-0">Movimientos de la cuenta</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-sm-10">
                                    <ul class="list-inline user-chat-nav mb-2">
                                        <div class="btn-group">
                                            <asp:Label ID="lbaccount" runat="server" Text="" Font-Bold="true" CssClass="form-control"></asp:Label>
                                        </div>
                                    </ul>
                                </div>
                                <div class="col-sm-2">
                                    <div class="text-sm-right">
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-outline-info waves-effect waves-light" data-placement="top"
                                                title="Imprimir listado" data-toggle="tooltip" runat="server" onserverclick="btprintdetail_ServerClick"
                                                id="btprintdetail">
                                                <i class="bx bx-printer"></i>
                                            </button>
                                        </div>
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-outline-danger waves-effect waves-light" data-placement="top" data-dismiss="modal"
                                                title="Salir" data-toggle="tooltip" aria-label="Close">
                                                <i class="bx bx-exit"></i>Salir
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="table-responsive">
                                <asp:GridView ID="gvdetail" CssClass="table table-normal table-bordered table-hover" runat="server"
                                    AutoGenerateColumns="false" AllowPaging="false" PageSize="15" OnRowDataBound="gvdetail_RowDataBound"
                                    EmptyDataText="No hay datos!" ShowHeaderWhenEmpty="true" ShowFooter="true" FooterStyle-BackColor="#EAFAF1"
                                    FooterStyle-Font-Bold="true" OnRowCommand="gvdetail_RowCommand">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Acción" ItemStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <div style="text-align: center;" runat="server" visible='<%# Eval("journalid").ToString().Length > 0 %>'>
                                                    <asp:LinkButton ID="lkprint" runat="server" CssClass="btn btn-outline-info btn-sm"
                                                        data-toggle="tooltip" data-placement="top" title="Imprimir entrada"
                                                        CommandArgument='<%# Eval("journalid").ToString() %>' CommandName="print"
                                                        CausesValidation="false"><i class="mdi mdi-printer font-size-12"></i></asp:LinkButton>

                                                    <asp:LinkButton ID="lkedit" runat="server" CssClass="btn btn-outline-info btn-sm"
                                                        data-toggle="tooltip" data-placement="top" title="Modifcar entrada"
                                                        CommandArgument='<%# Eval("journalid").ToString() %>' CommandName="editjournal"
                                                        CausesValidation="false"><i class="mdi mdi-pencil font-size-12"></i></asp:LinkButton>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="journalid" HeaderText="ED#" ItemStyle-Width="50" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="doctype" HeaderText="Tipo de documento" ItemStyle-Width="200" />
                                        <asp:BoundField DataField="number" HeaderText="Número" ItemStyle-Width="110" />
                                        <asp:BoundField DataField="create_date" HeaderText="Fecha" ItemStyle-Width="90" DataFormatString="{0:dd-MM-yyyy}"
                                            HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="concept" HeaderText="Concepto" ItemStyle-Width="180" />
                                        <asp:BoundField DataField="note" HeaderText="Observación" ItemStyle-Width="210" />
                                        <asp:BoundField DataField="debit" HeaderText="Débito" ItemStyle-Width="90" DataFormatString="{0:n}"
                                            HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right" />
                                        <asp:BoundField DataField="credit" HeaderText="Crédito" ItemStyle-Width="90" DataFormatString="{0:n}"
                                            HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right" />
                                        <asp:BoundField DataField="note_detail" HeaderText="Nota" ItemStyle-Width="210" />
                                    </Columns>
                                    <HeaderStyle BackColor="#5cb85c" BorderColor="#4CAE4C" ForeColor="White"></HeaderStyle>
                                    <PagerStyle Font-Size="Larger" ForeColor="Black" HorizontalAlign="Center" />
                                </asp:GridView>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="gvdetail" />
                            <asp:PostBackTrigger ControlID="btprintdetail" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!-- modal content -->
    <div id="myModalBalance" class="modal fade bs-example-modal-center" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
            <div class="modal-content" style="width: 1150px;">
                <div class="modal-header">
                    <h5 class="modal-title mt-0">Balance del Mes</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-sm-10">
                                    <ul class="list-inline user-chat-nav mb-2">
                                        <div class="btn-group">
                                            <asp:Label ID="lbaccount_balance" runat="server" Text="" Font-Bold="true" CssClass="form-control"></asp:Label>
                                        </div>
                                    </ul>
                                </div>
                                <div class="col-sm-2">
                                    <div class="text-sm-right">
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-outline-info waves-effect waves-light" data-placement="top"
                                                title="Imprimir Balance" data-toggle="tooltip" runat="server" onserverclick="btbalance_ServerClick"
                                                id="btbalance">
                                                <i class="bx bx-printer"></i>
                                            </button>
                                        </div>
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-outline-danger waves-effect waves-light" data-placement="top" data-dismiss="modal"
                                                title="Salir" data-toggle="tooltip" aria-label="Close">
                                                <i class="bx bx-exit"></i>Salir
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                        <ContentTemplate>
                            <div class="table-responsive">
                                <asp:GridView ID="gvbalance_month" CssClass="table table-normal table-bordered table-hover" runat="server"
                                    AutoGenerateColumns="false" AllowPaging="false" PageSize="15"
                                    EmptyDataText="No hay datos!" ShowHeaderWhenEmpty="true" ShowFooter="true" FooterStyle-BackColor="#EAFAF1"
                                    FooterStyle-Font-Bold="true">
                                    <Columns>
                                        <asp:BoundField DataField="accountid" HeaderText="Cuenta" ItemStyle-Width="90" />
                                        <asp:BoundField DataField="name" HeaderText="Nombre de la cuenta" ItemStyle-Width="210" />
                                        <asp:BoundField DataField="bce_anterior" HeaderText="Balance anterior" ItemStyle-Width="90" DataFormatString="{0:n}"
                                            HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right" />
                                        <asp:BoundField DataField="debit" HeaderText="Débitos del mes" ItemStyle-Width="90" DataFormatString="{0:n}"
                                            HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right" />
                                        <asp:BoundField DataField="credit" HeaderText="Créditos del mes" ItemStyle-Width="90" DataFormatString="{0:n}"
                                            HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right" />
                                        <asp:BoundField DataField="balance_debit" HeaderText="Balance débito" ItemStyle-Width="90" DataFormatString="{0:n}"
                                            HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right" />
                                        <asp:BoundField DataField="balance_credit" HeaderText="Balance crédito" ItemStyle-Width="90" DataFormatString="{0:n}"
                                            HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right" />
                                    </Columns>
                                    <HeaderStyle BackColor="#5cb85c" BorderColor="#4CAE4C" ForeColor="White"></HeaderStyle>
                                    <PagerStyle Font-Size="Larger" ForeColor="Black" HorizontalAlign="Center" />
                                </asp:GridView>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="gvbalance_month" />
                            <asp:PostBackTrigger ControlID="btbalance" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

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

    <script src="assets/libs/jquery/jquery.min.js"></script>
    <script src="assets/libs/select2/js/select2.min.js"></script>
    <script src="assets/libs/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
</asp:Content>
