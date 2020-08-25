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
                                        <div class="table-rep-plugin">
                                            <div class="row mb-2">
                                                <div class="col-sm-10">
                                                    <ul class="list-inline user-chat-nav mb-0">
                                                        <div class="btn-group">
                                                            <div class="input-group">
                                                                <div class="input-group-prepend">
                                                                    <div class="input-group-text"><i class="bx bx-calendar label-icon"></i></div>
                                                                </div>
                                                                <asp:DropDownList ID="cbyear" runat="server" CssClass="form-control">
                                                                    <asp:ListItem Value="2019" Text="2019" />
                                                                    <asp:ListItem Value="2020" Text="2020" />
                                                                    <asp:ListItem Value="2021" Text="2021" />
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="btn-group">
                                                            <asp:LinkButton ID="btn_refresh" CssClass="btn btn-light waves-effect btn-label waves-light" runat="server"
                                                                OnClick="btn_refresh_Click">
                                                                <i class="bx bx-repost label-icon"></i> Refrescar
                                                            </asp:LinkButton>
                                                        </div>
                                                        <asp:LinkButton ID="btn_export" CssClass="btn btn-light waves-effect btn-label waves-light" runat="server"
                                                            OnClientClick="setTimeout(function () {document.body.removeChild(modal);loading.style.display='none';}, 2000);ShowProgress()"
                                                            OnClick="btn_export_Click">
                                                            <i class="bx bx-printer label-icon"></i> Imprimir
                                                        </asp:LinkButton>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="table-responsive mb-0" data-pattern="priority-columns">
                                                <asp:GridView ID="gvbalance" runat="server" CssClass="table table-normal mb-0 table-bordered" 
                                                    AutoGenerateColumns="false" AllowPaging="false" PageSize="40" GridLines="Vertical" Font-Size="Smaller"
                                                    DataKeyNames="accountid" ShowFooter="false" FooterStyle-Font-Bold="true"
                                                    OnRowDataBound="gvbalance_RowDataBound">
                                                    <Columns>
                                                        <asp:TemplateField Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbisdetail" runat="server" Text='<%# Eval("isdetail") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="accountid" HeaderText="Cuenta" ItemStyle-Width="110" />
                                                        <asp:BoundField DataField="name" HeaderText="Nombre de la cuenta" ItemStyle-Width="250" />
                                                        <asp:BoundField DataField="ene" ItemStyle-Width="110" HeaderText="Ene" HeaderStyle-CssClass="text-right"                                                            
                                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:n}" />
                                                        <asp:BoundField DataField="feb" ItemStyle-Width="110" HeaderText="Feb" HeaderStyle-CssClass="text-right"                                                            
                                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:n}" />
                                                        <asp:BoundField DataField="mar" ItemStyle-Width="110" HeaderText="Mar" HeaderStyle-CssClass="text-right"                                                            
                                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:n}" />
                                                        <asp:BoundField DataField="abr" ItemStyle-Width="110" HeaderText="Abr" HeaderStyle-CssClass="text-right"                                                            
                                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:n}" />
                                                        <asp:BoundField DataField="may" ItemStyle-Width="110" HeaderText="May" HeaderStyle-CssClass="text-right"                                                            
                                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:n}" />
                                                        <asp:BoundField DataField="jun" ItemStyle-Width="110" HeaderText="Jun" HeaderStyle-CssClass="text-right"                                                            
                                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:n}" />
                                                        <asp:BoundField DataField="jul" ItemStyle-Width="110" HeaderText="Jul" HeaderStyle-CssClass="text-right"                                                            
                                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:n}" />
                                                        <asp:BoundField DataField="ago" ItemStyle-Width="110" HeaderText="Ago" HeaderStyle-CssClass="text-right"                                                            
                                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:n}" />
                                                        <asp:BoundField DataField="sep" ItemStyle-Width="110" HeaderText="Sep" HeaderStyle-CssClass="text-right"                                                            
                                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:n}" />
                                                        <asp:BoundField DataField="oct" ItemStyle-Width="110" HeaderText="Oct" HeaderStyle-CssClass="text-right"                                                            
                                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:n}" />
                                                        <asp:BoundField DataField="nov" ItemStyle-Width="110" HeaderText="Nov" HeaderStyle-CssClass="text-right"                                                            
                                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:n}" />
                                                        <asp:BoundField DataField="dic" ItemStyle-Width="110" HeaderText="Dic" HeaderStyle-CssClass="text-right"                                                            
                                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:n}" />
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
                        <asp:PostBackTrigger ControlID="gvbalance" />
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
