<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSigma.Master" AutoEventWireup="true" CodeBehind="newjournal.aspx.cs" Inherits="SigmaOnlineERP.newjournal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="assets/libs/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="assets/libs/@chenfengyuan/datepicker/datepicker.min.css">

    <!-- Sweet Alerts js -->
    <script type="text/javascript" src="assets/js/sweetalert.min.js"></script>
    <link href="assets/js/sweetalert.min.css" rel="stylesheet" type="text/css" />

    <style>
        textarea {
            resize: none;
        }

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
                            <h4 class="mb-0 font-size-18">Entrada de diario</h4>
                            <div class="page-title-right">
                                <ol class="breadcrumb m-0">
                                    <li class="breadcrumb-item"><a href="default.aspx">Inicio</a></li>
                                    <li class="breadcrumb-item"><a href="journalentry.aspx">Entradas de diario</a></li>
                                    <li class="breadcrumb-item active">Entrada</li>
                                </ol>
                            </div>
                        </div>  
                    </div>
                </div>
                <!-- end page title -->

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-lg-9">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="btn-group">
                                            <asp:LinkButton ID="btn_save" CssClass="btn btn-info waves-effect btn-label waves-light" runat="server"
                                                OnClick="btn_save_Click" CausesValidation="true">
                                                <i class="bx bx-save label-icon"></i> Grabar
                                            </asp:LinkButton>
                                        </div>
                                        <div class="btn-group">
                                            <asp:LinkButton ID="lk_close" runat="server" CssClass="btn btn-danger waves-effect btn-label waves-light"
                                                ausesValidation="false" OnClick="lk_close_Click">
                                                <i class="bx bx-exit label-icon"></i>Salir
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end row -->

                        <div class="row">
                            <div class="col-lg-9">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row mb-2">
                                            <div class="col-sm-4">
                                                <h4 class="card-title mb-4">Datos de la entrada</h4>
                                            </div>
                                        </div>

                                        <div role="form">
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label for="journalid">ID</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-id-card label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="journalid" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label for="create_date">Fecha</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-calendar label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="create_date" runat="server" placeholder="Fecha" CssClass="form-control" required AutoPostBack="true"
                                                                data-date-format="dd-mm-yyyy" data-provide="datepicker" data-date-autoclose="true" OnTextChanged="create_date_TextChanged"
                                                                oninvalid="this.setCustomValidity('Debes introducir la Fecha')" MaxLength="10"
                                                                oninput="setCustomValidity('')"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="cbtype">Tipo de documento</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-down-arrow label-icon"></i></div>
                                                            </div>
                                                            <asp:DropDownList ID="cbtype" runat="server" CssClass="form-control" DataValueField="doctypeid" AutoPostBack="true"
                                                                DataTextField="name" OnSelectedIndexChanged="cbtype_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label for="cbdimension">Dimensión</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-down-arrow label-icon"></i></div>
                                                            </div>
                                                            <asp:DropDownList ID="cbdimension" runat="server" CssClass="form-control" DataValueField="dimensionid"
                                                                DataTextField="name">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label for="number">Número</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text">#</div>
                                                            </div>
                                                            <asp:TextBox ID="number" runat="server" CssClass="form-control" required
                                                                oninvalid="this.setCustomValidity('Debes introducir el Número del Documento')" MaxLength="50"
                                                                oninput="setCustomValidity('')"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label for="reference">Referencia</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text">#</div>
                                                            </div>
                                                            <asp:TextBox ID="reference" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-5">
                                                    <div class="form-group">
                                                        <label for="cbsupplier">Proveedor</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="mdi mdi-truck-outline label-icon"></i></div>
                                                            </div>
                                                            <asp:DropDownList ID="cbsupplier" runat="server" CssClass="form-control" DataValueField="supplierid"
                                                                DataTextField="name">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-5">
                                                    <div class="form-group">
                                                        <label for="cbconcept">Concepto</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="mdi mdi-truck-outline label-icon"></i></div>
                                                            </div>
                                                            <asp:DropDownList ID="cbconcept" runat="server" CssClass="form-control" DataValueField="conceptid" AutoPostBack="true"
                                                                DataTextField="name" OnSelectedIndexChanged="cbconcept_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label for="note">Nota</label>
                                                        <div class="input-group mb-2 mr-sm-3">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text"><i class="bx bx-text label-icon"></i></div>
                                                            </div>
                                                            <asp:TextBox ID="note" runat="server" CssClass="form-control" required placeholder="Concepto o comentario" TextMode="MultiLine"
                                                                Rows="3" oninvalid="this.setCustomValidity('Debes introducir un Comentario')"
                                                                oninput="setCustomValidity('')"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="card overflow-hidden">
                                    <div class="bg-soft-primary">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="text-primary p-3">
                                                    <h5 class="text-primary">Hola !</h5>
                                                    <p>Aquí puedes digitar tus entradas de diario, colocando la cantidad de cuentas que necesites.</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end row -->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row mb-2">
                                            <div class="col-sm-8">
                                                <div class="text-sm-right">
                                                </div>
                                            </div>
                                        </div>
                                        <div role="form">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="table-responsive mb-0" data-pattern="priority-columns">
                                                        <asp:GridView ID="gvdetail" runat="server" CssClass="table table-normal mb-0 table-bordered"
                                                            AutoGenerateColumns="false" AllowPaging="false" PageSize="50" GridLines="Vertical" Font-Size="Smaller"
                                                            DataKeyNames="detailid" ShowFooter="true"
                                                            OnRowEditing="gvdetail_RowEditing" OnRowDataBound="gvdetail_RowDataBound" OnRowCancelingEdit="gvdetail_RowCancelingEdit"
                                                            OnRowUpdating="gvdetail_RowUpdating" OnRowDeleting="gvdetail_RowDeleting">
                                                            <Columns>
                                                                <asp:TemplateField ItemStyle-Width="1%">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lkrow" runat="server" Enabled="false">
                                                                            <i class="bx bxs-right-arrow font-size-12"></i>
                                                                        </asp:LinkButton>                                                                        
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Acción" ItemStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-Wrap="false">
                                                                    <ItemTemplate>
                                                                        <div style="text-align: center; text-wrap: avoid; width: 100%;" runat="server">
                                                                            <asp:LinkButton ID="lkedit" runat="server" CssClass="btn btn-outline-info btn-sm"
                                                                                CommandArgument='<%# Eval("detailid").ToString() %>'
                                                                                CommandName="Edit" CausesValidation="false">
                                                                                <i class="mdi mdi-pencil font-size-12"></i>
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="lkdelete" runat="server" CssClass="btn btn-outline-danger btn-sm"
                                                                                CommandArgument='<%# Eval("detailid").ToString() %>' CommandName="Delete" CausesValidation="false">
                                                                                <i class="mdi mdi-trash-can font-size-12"></i>
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <div style="text-align: center; width: 100%; text-wrap: unset;" runat="server">
                                                                            <asp:LinkButton ID="lkcancel" runat="server" CssClass="btn btn-outline-danger btn-sm"
                                                                                CommandArgument='<%# Eval("detailid").ToString() %>' CommandName="Cancel" CausesValidation="false">
                                                                                <i class="mdi mdi-cancel font-size-12"></i>
                                                                            </asp:LinkButton>
                                                                            <asp:LinkButton ID="lksave" runat="server" CssClass="btn btn-outline-info btn-sm"
                                                                                CommandArgument='<%# Eval("detailid").ToString() %>' CommandName="Update" CausesValidation="false">
                                                                                <i class="fas fa-save font-size-12"></i>
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </EditItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="NO." ItemStyle-Width="2%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbdetailid" CssClass="form-control" runat="server" Text='<%# Eval("detailid") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="CUENTA" ItemStyle-Width="15%">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbaccountid" CssClass="form-control" runat="server" Text='<%# Eval("accountid") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:Label ID="lbedit_accountid" CssClass="form-control" runat="server" Text='<%# Eval("accountid") %>'></asp:Label>
                                                                    </EditItemTemplate>
                                                                    <FooterTemplate>
                                                                        <asp:LinkButton ID="lkaddline" runat="server" CssClass="btn btn-success btn-sm" OnClick="lkaddline_Click">
                                                                            <i class="fas fa-plus font-size-12"></i> Insertar línea
                                                                        </asp:LinkButton>
                                                                    </FooterTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="NOMBRE DE LA CUENTA" ItemStyle-Width="25%">
                                                                    <ItemTemplate>
                                                                        <asp:DropDownList ID="cbname" runat="server" CssClass="form-control" Enabled="false"
                                                                            DataTextField="name" DataValueField="accountid"></asp:DropDownList>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:DropDownList ID="edit_cbname" runat="server" CssClass="form-control" BorderColor="Teal" AutoPostBack="true"
                                                                            DataTextField="name" DataValueField="accountid"
                                                                            OnSelectedIndexChanged="edit_cbname_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                    </EditItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="ORIGEN" ItemStyle-Width="10%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center"
                                                                    FooterStyle-HorizontalAlign="Right">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lborigin" CssClass="form-control" runat="server"
                                                                            Text='<%# Eval("origin").ToString() == "D" ? "Débito" : "Crédito" %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:DropDownList ID="cborigin" runat="server" CssClass="form-control" BorderColor="Teal" AutoPostBack="true"
                                                                            OnSelectedIndexChanged="cborigin_SelectedIndexChanged">
                                                                            <asp:ListItem Text="Débito" Value="D" />
                                                                            <asp:ListItem Text="Crédito" Value="C" />
                                                                        </asp:DropDownList>
                                                                    </EditItemTemplate>
                                                                    <FooterTemplate>
                                                                        <b>TOTAL GENERAL:</b>
                                                                    </FooterTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="DÉBITO" HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" 
                                                                    ItemStyle-Width="10%" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbdebit" CssClass="form-control" runat="server"
                                                                            Text='<%# Convert.ToDecimal(Eval("debit")).ToString("##,###,##0.00") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="edit_debit" CssClass="form-control text-right" runat="server" BorderColor="Teal" 
                                                                            onfocus="$(this).css('background-color','#EAFAF1'); this.select();"
                                                                            onblur="$(this).css('background-color', '');"
                                                                            Text='<%# Eval("debit") %>'></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <FooterTemplate>
                                                                        <asp:Label ID="lbtotal_debit" runat="server" Text="0.00" CssClass="form-control" Font-Bold="true"></asp:Label>
                                                                    </FooterTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="CRÉDITO" HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" 
                                                                    ItemStyle-Width="10%" FooterStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbcredit" CssClass="form-control" runat="server"
                                                                            Text='<%# Convert.ToDecimal(Eval("credit")).ToString("##,###,##0.00") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="edit_credit" CssClass="form-control text-right" runat="server" BorderColor="Teal" 
                                                                            onfocus="$(this).css('background-color','#EAFAF1'); this.select();"
                                                                            onblur="$(this).css('background-color', '');"
                                                                            Text='<%# Eval("credit") %>'></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <FooterTemplate>
                                                                        <asp:Label ID="lbtotal_credit" runat="server" Text="0.00" CssClass="form-control" Font-Bold="true"></asp:Label>
                                                                    </FooterTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="CONCEPTO" ItemStyle-Width="20%" ItemStyle-Wrap="false">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="lbnote" CssClass="form-control" runat="server" Text='<%# Eval("note") %>' ReadOnly="true"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="edit_note" CssClass="form-control" runat="server" BorderColor="Teal" Text='<%# Eval("note") %>'
                                                                            onfocus="$(this).css('background-color','#EAFAF1');"
                                                                            onblur="$(this).css('background-color', '');"></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <FooterTemplate>
                                                                        <asp:Label ID="lbdescuadrado" runat="server" Text="Documento descuadrado" CssClass="form-control" ForeColor="Red"></asp:Label>
                                                                    </FooterTemplate>
                                                                </asp:TemplateField>
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
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>

    <!-- Footer Start -->
    <%
        Response.WriteFile("assets/footer.html");
    %>
    <!-- end Footer -->

    </div>

    <script src="assets/libs/jquery/jquery.min.js"></script>
    <script src="assets/libs/select2/js/select2.min.js"></script>
    <script src="assets/libs/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
    <script src="assets/libs/@chenfengyuan/datepicker/datepicker.min.js"></script>
</asp:Content>