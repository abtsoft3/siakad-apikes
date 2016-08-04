
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>SIAKAD-APIKES |@yield('title') </title>
	
	<!--jquery ui-->
	<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/smoothness/jquery-ui.min.css" rel="stylesheet" type="text/css" />
    <!-- Bootstrap -->
    <link href="{{ URL::asset('vendors/bootstrap/dist/css/bootstrap.min.css')}}" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="{{ URL::asset('vendors/font-awesome/css/font-awesome.min.css')}}" rel="stylesheet">
    <!-- NProgress -->
    <link href="{{ URL::asset('vendors/nprogress/nprogress.css')}}" rel="stylesheet">
	
	@yield('css')
	
    <!-- Custom Theme Style -->
    <link href="{{ URL::asset('build/css/custom.min.css')}}" rel="stylesheet">
	
  </head>

  <body class="nav-md">
 
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="index.html" class="site_title"><span>SIAKAD APIKES</span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile">
              <div class="profile_pic">
                <img src="{{ URL::asset('images/img.jpg')}}" alt="img-profile" class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Welcome,</span>
                <h2> {{ Auth::user()->name }}</h2>
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />

            <!-- sidebar menu -->
			 @section('sidebar')
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <h3>@if(Auth::user()->admin)
                Administrator
                @elseif(Auth::check('usermahasiswa'))
				Mahasiswa
                Guess
                @endif</h3>
                <ul class="nav side-menu">
                
                  <li><a><i class="fa fa-user"></i> Mahasiswa <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{url('/home/addmahasiswa')}}">Tambah</a></li>
                      <li><a href="{{url('/home/showmahasiswa')}}">Tampilkan</a></li>
                    </ul>
                  </li>
             <li><a><i class="fa fa-clone"></i> MataKuliah <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{url('/home/addmatakuliah')}}">Tambah</a></li>
                      <li><a href="{{url('/home/showmatakuliah')}}">Tampilkan</a></li>
                      
                    </ul>
                  </li>
           <li><a><i class="fa fa-calendar"></i> Periode <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{url('/home/addperiode')}}">Tambah</a></li>
                      <li><a href="{{url('/home/showperiode')}}">Tampilkan</a></li>
                      
                    </ul>
                  </li>
                 
                  <!--li><a><i class="fa fa-table"></i> DATASET <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="tables.html">Tables</a></li>
                      <li><a href="tables_dynamic.html">Table Dynamic</a></li>
                    </ul>
                  </li>
          
                  <li><a><i class="fa fa-bar-chart-o"></i> Data Presentation <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="chartjs.html">Chart JS</a></li>
                      <li><a href="chartjs2.html">Chart JS2</a></li>
                      <li><a href="morisjs.html">Moris JS</a></li>
                      <li><a href="echarts.html">ECharts</a></li>
                      <li><a href="other_charts.html">Other Charts</a></li>
                    </ul>
                  </li-->
                  
        
          
           <li><a><i class="fa fa-sitemap"></i> Angkatan <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li><a href="#level1_1">Tambah</a>
                        </li>
                        <li><a href="#level1_2">Tampilkan</a>
                        </li>
                    </ul>
                  </li> 
                
                  <li><a><i class="fa fa-bug"></i> Administrator <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
            <li><a href="{{url('register_user')}}"> Tambah</a></li>
             <li><a href="#">Tampilkan</a></li>
                      
                      
                    </ul>
                  </li>
          <li><a><i class="fa fa-bug"></i> Dosen <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
            <li><a href="{{url('/home/register_dosen')}}"> Tambah</a></li>
             <li><a href="#">Tampilkan</a></li>
                      
                      
                    </ul>
                  </li>
          <li><a><i class="fa fa-bug"></i> Mahasiswa <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
            <li><a href="{{url('/home/register_mahasiswa')}}"> Tambah</a></li>
            <li><a href="{{url('/home/show_users_mahasiswa')}}">Tampilkan</a></li>
                      
                      
                    </ul>
                  </li>


                  <!-- <li><a><i class="fa fa-edit"></i> KRS <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{url('/home/addkrs')}}">Pengisian KRS</a></li>
                      <li><a href="{{url('/home/listkrs')}}">Lihat KRS</a></li>
                       <li><a href="{{url('list_krs')}}">Lihat KRS 1</a></li> 
                    </ul>
                  </li> -->
                  @else

				  
          <!-- tutup dulu
                  <li><a><i class="fa fa-windows"></i> Extras <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="page_403.html">403 Error</a></li>
                      <li><a href="page_404.html">404 Error</a></li>
                      <li><a href="page_500.html">500 Error</a></li>
                      <li><a href="plain_page.html">Plain Page</a></li>
                      <li><a href="login.html">Login Page</a></li>
                      <li><a href="pricing_tables.html">Pricing Tables</a></li>
                    </ul>
                  </li>
                                  
                  <li><a href="javascript:void(0)"><i class="fa fa-laptop"></i> Landing Page <span class="label label-success pull-right">Coming Soon</span></a></li>
          -->

                <li><a href="{{url('/home')}}"><i class="fa fa-home"></i> Home </a></li>
                  <li><a><i class="fa fa-edit"></i> KRS <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{url('/home/add_krs')}}">Pengisian KRS</a></li>
                      <li><a href="{{url('/home/list_krs')}}">Lihat KRS</a></li>
             <li><a href="{{url('list_krs')}}">Lihat KRS 1</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-desktop"></i> KHS <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="general_elements.html">General Elements</a></li>
                      
                    </ul>
                  </li>
                 </ul>
                
              </div>
             

            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
            <div class="sidebar-footer hidden-small">
              <a data-toggle="tooltip" data-placement="top" title="Settings">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Logout">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
              </a>
            </div>
            <!-- /menu footer buttons -->
          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <img src="{{ URL::asset('images/img.jpg')}}" alt="img1"> {{ Auth::user()->name }}
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                    <li><a href="{{url('/')}}"> Profile</a></li>
                   
                    
                    <li><a href="{{ url('/logout') }}"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
                  </ul>
                </li>

                <!--li role="presentation" class="dropdown">
                  <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-envelope-o"></i>
                    <span class="badge bg-green">6</span>
                  </a>
                </li-->
              </ul>
            </nav>
          </div>
        </div>
		 @show
        <!-- /top navigation -->

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="row top_tiles">
			
            </div>
            <div class="row">
              <div class="col-md-12 col-lg-12 col-xs-12 col-sm-12">
                @yield('content')
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
            SIAKAD APIKES IMELDA - designed by <a href="#">ABT soft</a>
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="{{ URL::asset('vendors/jquery/dist/jquery.min.js')}}"></script>
    <!-- Bootstrap -->
    <script src="{{ URL::asset('vendors/bootstrap/dist/js/bootstrap.min.js')}}"></script>
    <!-- FastClick -->
    <script src="{{ URL::asset('vendors/fastclick/lib/fastclick.js')}}"></script>
    <!-- NProgress -->
    <script src="{{ URL::asset('vendors/nprogress/nprogress.js')}}"></script>
	
	@yield('scripts')
	
    <!-- Custom Theme Scripts -->
    <script src="{{ URL::asset('build/js/custom.min.js')}}"></script>
	
  </body>

</html>
