<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSigma.Master" AutoEventWireup="true" CodeBehind="config.aspx.cs" Inherits="SigmaOnlineERP.config" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="assets/libs/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/libs/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="assets/libs/@chenfengyuan/datepicker/datepicker.min.css">

    <style>
        .table-normal td{
            padding: .40rem;
            vertical-align: middle;
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
                            <h4 class="mb-0 font-size-18">Configuración general</h4>
                            <div class="page-title-right">
                                <ol class="breadcrumb m-0">
                                    <li class="breadcrumb-item"><a href="default.aspx">Inicio</a></li>
                                    <li class="breadcrumb-item active">Configuración</li>
                                </ol>
                            </div>
                        </div>  
                    </div>
                </div>
                <!-- end page title -->

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="checkout-tabs">
                            <div class="row">
                                <div class="col-xl-2 col-sm-3">
                                    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                                        <a class="nav-link active" id="v-ncf-tab" data-toggle="pill" href="#v-ncf" role="tab" aria-controls="v-pills-shipping" aria-selected="true">
                                            <i class="bx bxs-food-menu d-block check-nav-icon mt-2 mb-2"></i>
                                            <p class="font-weight-bold mb-2">Comprobantes fiscales</p>
                                        </a>
                                        <a class="nav-link" id="v-pills-payment-tab" data-toggle="pill" href="#v-pills-payment" role="tab" 
                                            aria-controls="v-pills-payment" aria-selected="false">
                                            <i class="bx bxs-dollar-circle d-block check-nav-icon mt-2 mb-2"></i>
                                            <p class="font-weight-bold mb-2">Subscripción y pago</p>
                                        </a>
                                    </div>
                                </div>
                                <div class="col-xl-8">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="tab-content" id="v-pills-tabContent">
                                                <div class="tab-pane fade show active" id="v-ncf" role="tabpanel" aria-labelledby="v-ncf-tab">
                                                    <h4 class="card-title">Comprobantes fiscales</h4>
                                                    <p class="card-title-desc">Selecciona y configura tus comprobates fiscales</p>
                                                    <div role="form">
                                                        <div class="table-responsive mb-0" data-pattern="priority-columns">
                                                            <asp:GridView ID="gvncf" runat="server" CssClass="table table-normal mb-0 table-bordered"
                                                                AutoGenerateColumns="false" AllowPaging="true" PageSize="50" GridLines="Vertical" Font-Size="Smaller"
                                                                DataKeyNames="ncfid" OnRowEditing="gvncf_RowEditing" OnRowCommand="gvncf_RowCommand"
                                                                OnRowCancelingEdit="gvncf_RowCancelingEdit" OnRowUpdating="gvncf_RowUpdating" 
                                                                EditRowStyle-CssClass="table table-normal mb-0 table-bordered">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Acción" ItemStyle-Width="90" HeaderStyle-HorizontalAlign="Center">
                                                                        <ItemTemplate>
                                                                            <div style="text-align: center;" runat="server">
                                                                                <asp:LinkButton ID="lkedit" runat="server" CssClass="btn btn-outline-info btn-sm" 
                                                                                    CommandArgument='<%# Eval("ncfid").ToString() %>'
                                                                                    CommandName="Edit" AlternateText="Modifcar datos" CausesValidation="false">
                                                                                    <i class="mdi mdi-pencil font-size-12"></i>
                                                                                </asp:LinkButton>
                                                                                <asp:LinkButton ID="lkcancel" runat="server" CssClass="btn btn-outline-danger btn-sm" 
                                                                                    CommandArgument='<%# Eval("ncfid").ToString() %>'
                                                                                    CommandName="inactivate" Visible='<%# Eval("isenabled").ToString() == "1" %>' CausesValidation="false"
                                                                                    AlternateText="Inactivar"><i class="mdi mdi-close font-size-12"></i>
                                                                                </asp:LinkButton>
                                                                                <asp:LinkButton ID="lkactive" runat="server" CssClass="btn btn-outline-success btn-sm" CommandArgument='<%# Eval("ncfid").ToString() %>'
                                                                                    CommandName="activate" Visible='<%# Eval("isenabled").ToString() == "0" %>' CausesValidation="false"
                                                                                    AlternateText="activar"><i class="mdi mdi-check font-size-12"></i>
                                                                                </asp:LinkButton>
                                                                            </div>
                                                                        </ItemTemplate>
                                                                        <EditItemTemplate>
                                                                            <div style="text-align: center;" runat="server">
                                                                                <asp:LinkButton ID="lkcancel" runat="server" CssClass="btn btn-outline-danger btn-sm" 
                                                                                    CommandArgument='<%# Eval("ncfid").ToString() %>' CommandName="Cancel" CausesValidation="false">
                                                                                        <i class="mdi mdi-cancel font-size-12"></i>
                                                                                </asp:LinkButton>
                                                                                <asp:LinkButton ID="lksave" runat="server" CssClass="btn btn-outline-info btn-sm" 
                                                                                    CommandArgument='<%# Eval("ncfid").ToString() %>' CommandName="Update" CausesValidation="false">
                                                                                        <i class="fas fa-save font-size-12"></i>
                                                                                </asp:LinkButton>
                                                                            </div>
                                                                        </EditItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="name" HeaderText="TIPO DE COMPROBANTE" ItemStyle-Width="220" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" />
                                                                    <asp:TemplateField HeaderText="SERIE" ItemStyle-Width="80">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbserie" CssClass="form-control" runat="server" Text='<%# Eval("serie") %>' Width="80"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>

                                                                    <asp:TemplateField HeaderText="INICIO" ItemStyle-Width="80">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbdesde" CssClass="form-control" runat="server" Text='<%# Eval("desde") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <EditItemTemplate>
                                                                            <asp:TextBox ID="edit_desde" CssClass="form-control" runat="server" BorderColor="Blue"
                                                                                Text='<%# Eval("desde") %>' Width="80"></asp:TextBox>
                                                                        </EditItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="FIN" ItemStyle-Width="80">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbhasta" CssClass="form-control" runat="server" Text='<%# Eval("hasta") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <EditItemTemplate>
                                                                            <asp:TextBox ID="edit_hasta" CssClass="form-control" runat="server" BorderColor="Blue"
                                                                                Text='<%# Eval("hasta") %>' Width="80"></asp:TextBox>
                                                                        </EditItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ACTUAL" ItemStyle-Width="80">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbsecuencia" CssClass="form-control" runat="server" Text='<%# Eval("secuencia") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <EditItemTemplate>
                                                                            <asp:TextBox ID="edit_secuencia" CssClass="form-control" runat="server" BorderColor="Blue"
                                                                                Text='<%# Eval("secuencia") %>' Width="80"></asp:TextBox>
                                                                        </EditItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="FECHA VENCE" ItemStyle-Width="110">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbvence" CssClass="form-control" runat="server" Text='<%# Eval("ncf_vence") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <EditItemTemplate>
                                                                            <asp:TextBox ID="edit_vence" runat="server" Text='<%# Eval("ncf_vence") %>' Width="110" BorderColor="Blue"
                                                                                CssClass="form-control" data-date-format="dd-mm-yyyy" data-provide="datepicker"
                                                                                data-date-autoclose="true"></asp:TextBox>
                                                                        </EditItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField ItemStyle-VerticalAlign="Middle" ItemStyle-Width="30" ItemStyle-HorizontalAlign="Center" HeaderText="ESTATUS">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbestatus" CssClass="form-control" runat="server" 
                                                                                ForeColor='<%# Eval("isenabled").ToString() == "1" ? System.Drawing.Color.FromName("#495057") : System.Drawing.Color.Red %>'
                                                                                Text='<%# Eval("isenabled").ToString() == "1" ? "Activo" : "Inactivo" %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerSettings Visible="true" />
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="tab-pane fade" id="v-pills-payment" role="tabpanel" aria-labelledby="v-pills-payment-tab">
                                                    <div>
                                                        <h4 class="card-title">Payment information</h4>
                                                        <p class="card-title-desc">Fill all information below</p>
                                                        <div>
                                                            <div class="custom-control custom-radio custom-control-inline mr-4">
                                                                <input type="radio" id="customRadioInline1" name="customRadioInline1" class="custom-control-input">
                                                                <label class="custom-control-label" for="customRadioInline1"><i class="fab fa-cc-mastercard mr-1 font-size-20 align-top"></i>Credit / Debit Card</label>
                                                            </div>
                                                            <div class="custom-control custom-radio custom-control-inline mr-4">
                                                                <input type="radio" id="customRadioInline2" name="customRadioInline1" class="custom-control-input">
                                                                <label class="custom-control-label" for="customRadioInline2"><i class="fab fa-cc-paypal mr-1 font-size-20 align-top"></i>Paypal</label>
                                                            </div>
                                                            <div class="custom-control custom-radio custom-control-inline mr-4">
                                                                <input type="radio" id="customRadioInline3" name="customRadioInline1" class="custom-control-input" checked>
                                                                <label class="custom-control-label" for="customRadioInline3"><i class="far fa-money-bill-alt mr-1 font-size-20 align-top"></i>Cash on Delivery</label>
                                                            </div>
                                                        </div>

                                                        <h5 class="mt-5 mb-3 font-size-15">For card Payment</h5>
                                                        <div class="p-4 border">
                                                            <form>
                                                                <div class="form-group mb-0">
                                                                    <label for="cardnumberInput">Card Number</label>
                                                                    <input type="text" class="form-control" id="cardnumberInput" placeholder="0000 0000 0000 0000">
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-lg-6">
                                                                        <div class="form-group mt-4 mb-0">
                                                                            <label for="cardnameInput">Name on card</label>
                                                                            <input type="text" class="form-control" id="cardnameInput" placeholder="Name on Card">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-3">
                                                                        <div class="form-group mt-4 mb-0">
                                                                            <label for="expirydateInput">Expiry date</label>
                                                                            <input type="text" class="form-control" id="expirydateInput" placeholder="MM/YY">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-3">
                                                                        <div class="form-group mt-4 mb-0">
                                                                            <label for="cvvcodeInput">CVV Code</label>
                                                                            <input type="text" class="form-control" id="cvvcodeInput" placeholder="Enter CVV Code">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </form>
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

    <script src="assets/libs/jquery/jquery.min.js"></script>
    <script src="assets/libs/select2/js/select2.min.js"></script>
    <script src="assets/libs/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
    <script src="assets/libs/@chenfengyuan/datepicker/datepicker.min.js"></script>

</asp:Content>
