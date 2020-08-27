<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSigma.Master" AutoEventWireup="true" CodeBehind="generaldiary.aspx.cs" Inherits="SigmaOnlineERP.generaldiary"
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
                            <h4 class="mb-0 font-size-18">Diario General</h4>
                            <div class="page-title-right">
                                <ol class="breadcrumb m-0">
                                    <li class="breadcrumb-item"><a href="default.aspx">Inicio</a></li>
                                    <li class="breadcrumb-item active">Diario general</li>
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
                                                    <div class="btn-group">
                                                        <div class="input-group">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-calendar label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="date_start" runat="server" placeholder="Inicio" CssClass="form-control" Width="120px"
                                                                data-date-format="dd-mm-yyyy" data-provide="datepicker" data-date-autoclose="true"
                                                                MaxLength="10" oninput="setCustomValidity('')"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="btn-group">
                                                        <div class="input-group">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-calendar label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="date_end" runat="server" placeholder="Fin" CssClass="form-control" Width="120px"
                                                                data-date-format="dd-mm-yyyy" data-provide="datepicker" data-date-autoclose="true"
                                                                MaxLength="10" oninput="setCustomValidity('')"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="btn-group">
                                                        <span data-toggle="modal" data-target="#myModal">
                                                            <button type="button" class="btn btn-outline-info waves-effect waves-light" data-placement="top" 
                                                                title="Filtrar" data-toggle="tooltip">
                                                                <i class="mdi mdi-filter-outline"></i>
                                                            </button>
                                                        </span>
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
                                            <div class="col-sm-2">
                                                <div class="text-sm-right">
                                                    <asp:LinkButton ID="btn_add" CssClass="btn btn-success waves-effect btn-label waves-light" runat="server"
                                                        OnClick="btn_add_Click">
                                                            <i class="bx bx-plus label-icon"></i> Nueva entrada
                                                    </asp:LinkButton>
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
                                                <asp:GridView ID="gvjournal" runat="server" CssClass="table table-normal mb-0 table-bordered" 
                                                    AutoGenerateColumns="false" AllowPaging="true" PageSize="40" GridLines="Vertical" Font-Size="Smaller"
                                                    DataKeyNames="journalid" ShowFooter="false" OnRowCreated="gvjournal_RowCreated" OnDataBound="gvjournal_DataBound"
                                                    FooterStyle-Font-Bold="true"
                                                    FooterStyle-BackColor="#EAFAF1">
                                                    <Columns>
                                                        <asp:BoundField DataField="journalid" HeaderText="ED#" ItemStyle-Width="50" HeaderStyle-CssClass="text-center"
                                                            ItemStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="number" HeaderText="Número" ItemStyle-Width="110" />
                                                        <asp:BoundField DataField="doctype" HeaderText="Tipo de documento" ItemStyle-Width="210" />
                                                        <asp:BoundField DataField="create_date" HeaderText="Fecha" ItemStyle-Width="110" />
                                                        <asp:BoundField DataField="concept" HeaderText="Concepto" ItemStyle-Width="210" />
                                                        <asp:BoundField DataField="accountid" HeaderText="Cuenta" ItemStyle-Width="110" />
                                                        <asp:BoundField DataField="name" HeaderText="Nombre de la cuenta" ItemStyle-Width="250" />
                                                        <asp:BoundField DataField="debit" ItemStyle-Width="110" HeaderText="Débito" HeaderStyle-CssClass="text-center"                                                            
                                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:n}" />
                                                        <asp:BoundField DataField="credit" ItemStyle-Width="110" HeaderText="Crédito" HeaderStyle-CssClass="text-center"
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
                        <asp:PostBackTrigger ControlID="gvjournal" />
                        <asp:PostBackTrigger ControlID="btn_export" />
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
    <div id="myModal" class="modal fade bs-example-modal-center" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mt-0">Movimientos de la cuenta</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="row mb-2">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="cbdoctype">Tipo</label>
                                        <div class="input-group mb-2 mr-sm-3">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text"><i class="mdi mdi-grid label-icon"></i></div>
                                            </div>
                                            <asp:DropDownList ID="cbdoctype" runat="server" CssClass="form-control"
                                                DataTextField="name" DataValueField="doctypeid" AutoPostBack="true" OnSelectedIndexChanged="cbdoctype_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="cbconcept">Concepto</label>
                                        <div class="input-group mb-2 mr-sm-3">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text"><i class="mdi mdi-grid label-icon"></i></div>
                                            </div>
                                            <asp:DropDownList ID="cbconcept" runat="server" CssClass="form-control"
                                                DataTextField="name" DataValueField="conceptid" AutoPostBack="true" OnSelectedIndexChanged="cbconcept_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
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
