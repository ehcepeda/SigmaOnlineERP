<%@ Page Title="" Language="C#" MasterPageFile="~/SiteSigma.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="SigmaOnlineERP._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <div class="main-content">
        <div class="page-content">
            <div class="container-fluid">
                <!-- start page title -->
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box d-flex align-items-center justify-content-between">
                            <h4 class="mb-0 font-size-18">Dashboard</h4>
                            <div class="page-title-right">
                                <ol class="breadcrumb m-0">
                                    <li class="breadcrumb-item"><a href="javascript: void(0);">Dashboard</a></li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end page title -->

                <div class="row">
                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body border-top">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div>
                                            <p class="text-muted mb-2">Balance cuentas USD$</p>
                                            <h5>$ 9,148.23</h5>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="text-sm-right mt-4 mt-sm-0">
                                            <p class="text-muted mb-2">Última transacción</p>
                                            <h5>+ $ 248.35</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="card-body border-top">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div>
                                            <p class="text-muted mb-2">Balance cuentas RD$</p>
                                            <h5>$ 9,148.23</h5>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="text-sm-right mt-4 mt-sm-0">
                                            <p class="text-muted mb-2">Última transacción</p>
                                            <h5>+ $ 248.35</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="card-body border-top">
                                <p class="text-muted mb-4">Transacciones del mes</p>
                                <div class="text-center">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="mt-4 mt-sm-0">
                                                <div class="font-size-24 text-primary mb-2">
                                                    <i class="bx bx-import"></i>
                                                </div>

                                                <p class="text-muted mb-2">Ingresos</p>
                                                <h5>$ 1,000,054.32</h5>

                                                <div class="mt-3">
                                                    <a href="#" class="btn btn-primary btn-sm w-md">Detalle</a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div>
                                                <div class="font-size-24 text-primary mb-2">
                                                    <i class="bx bx-send"></i>
                                                </div>

                                                <p class="text-muted mb-2">Gastos</p>
                                                <h5>$ 850,000.42</h5>

                                                <div class="mt-3">
                                                    <a href="#" class="btn btn-primary btn-sm w-md">Detalle</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="col-xl-8">
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="card mini-stats-wid">
                                    <div class="card-body">
                                        <div class="media">
                                            <div class="mr-3 align-self-center">
                                                <i class="mdi mdi-bitcoin h2 text-warning mb-0"></i>
                                            </div>
                                            <div class="media-body">
                                                <p class="text-muted mb-2">Cuentas por cobrar</p>
                                                <h5 class="mb-0"><span class="font-size-14 text-muted">$ 9,148,000.00</span></h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="card mini-stats-wid">
                                    <div class="card-body">
                                        <div class="media">
                                            <div class="mr-3 align-self-center">
                                                <i class="mdi mdi-ethereum h2 text-primary mb-0"></i>
                                            </div>
                                            <div class="media-body">
                                                <p class="text-muted mb-2">Cuentas por pagar</p>
                                                <h5 class="mb-0"><span class="font-size-14 text-muted">$ 5,111,235.00</span></h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="card mini-stats-wid">
                                    <div class="card-body">
                                        <div class="media">
                                            <div class="mr-3 align-self-center">
                                                <i class="mdi mdi-litecoin h2 text-info mb-0"></i>
                                            </div>
                                            <div class="media-body">
                                                <p class="text-muted mb-2">Préstamos</p>
                                                <h5 class="mb-0"><span class="font-size-14 text-muted">$ 4,721.00</span></h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end row -->

                        <div class="card">
                            <div class="card-body mb-4">
                                <h4 class="card-title">Pronóstico a 30 días</h4>
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="border p-3 rounded mt-4">
                                            <div class="d-flex align-items-center mb-3">
                                                <div class="avatar-xs mr-3">
                                                    <span class="avatar-title rounded-circle bg-soft-warning text-warning font-size-18">
                                                        <i class="mdi mdi-bitcoin"></i>
                                                    </span>
                                                </div>
                                                <h5 class="font-size-14 mb-0">Cobros</h5>
                                            </div>

                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="text-muted mt-3">
                                                        <p>Annual Yield</p>
                                                        <h4>4.05 %</h4>
                                                        <p class="mb-0">0.00745 BTC</p>

                                                    </div>
                                                </div>

                                                <div class="col-lg-6 align-self-end">
                                                    <div class="float-right mt-3">
                                                        <a href="#" class="btn btn-primary">Detalle</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="border p-3 rounded mt-4">
                                            <div class="d-flex align-items-center mb-3">
                                                <div class="avatar-xs mr-3">
                                                    <span class="avatar-title rounded-circle bg-soft-primary text-primary font-size-18">
                                                        <i class="mdi mdi-ethereum"></i>
                                                    </span>
                                                </div>
                                                <h5 class="font-size-14 mb-0">Pagos</h5>
                                            </div>

                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="text-muted mt-3">
                                                        <p>Annual Yield</p>
                                                        <h4>5.08 %</h4>
                                                        <p class="mb-0">0.0056 ETH</p>
                                                    </div>
                                                </div>

                                                <div class="col-lg-6 align-self-end">
                                                    <div class="float-right mt-3">
                                                        <a href="#" class="btn btn-primary">Detalle</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="border p-3 rounded mt-4">
                                            <div class="d-flex align-items-center mb-3">
                                                <div class="avatar-xs mr-3">
                                                    <span class="avatar-title rounded-circle bg-soft-info text-info font-size-18">
                                                        <i class="mdi mdi-litecoin"></i>
                                                    </span>
                                                </div>
                                                <h5 class="font-size-14 mb-0">Nómina</h5>
                                            </div>

                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="text-muted mt-3">
                                                        <p>Annual Yield</p>
                                                        <h4>4.12 %</h4>
                                                        <p class="mb-0">0.00245 LTC</p>

                                                    </div>
                                                </div>

                                                <div class="col-lg-6 align-self-end">
                                                    <div class="float-right mt-3">
                                                        <a href="#" class="btn btn-primary">Detalle</a>
                                                    </div>
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

                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title mb-4">Resultado del año</h4>
                                <div id="mix-line-bar" class="charts" style="height: 350px;"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->

            </div>
        </div>
    </div>

    <!-- Footer Start -->
    <%
        Response.WriteFile("assets/footer.html");
    %>
    <!-- end Footer -->

    <!-- apexcharts -->
    <script src="assets/libs/apexcharts/apexcharts.min.js"></script>

    <script type="text/javascript">
        google.charts.load('current', { 'packages': ['corechart'] });
        google.charts.setOnLoadCallback(drawVisualization);

        function drawVisualization() {
            // Some raw data (not necessarily accurate)
            var data = google.visualization.arrayToDataTable([
                ['Month', 'Ingresos', 'Egresos', 'Ganancia', 'Average'],
                ['Enero', 522, 998, 450, 614.6],
                ['Febrero', 599, 1268, 288, 682],
                ['Marzo', 587, 807, 397, 623],
                ['Abril', 615, 968, 215, 609],
                ['Mayo', 629, 1026, 366, 569],
                ['Junio', 629, 1026, 366, 569],
                ['Julio', 629, 1026, 366, 569],
                ['Agosto', 629, 1026, 366, 569],
                ['Septiembre', 0, 0, 0, 569],
                ['Octubre', 0, 0, 0, 569],
                ['Noviembre', 0, 0, 0, 569],
                ['Diciembre', 0, 0, 0, 569]
            ]);

            var options = {
                seriesType: 'bars',
                series: { 3: { type: 'line' } }
            };

            var chart = new google.visualization.ComboChart(document.getElementById('mix-line-bar'));
            chart.draw(data, options);
        }
    </script>
</asp:Content>
