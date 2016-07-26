@extends('layouts.master')

@section('title','Periode')
@section('css')
  <!-- Datatables -->
    <link href="{{ URL::asset('vendors/datatables.net-bs/css/dataTables.bootstrap.min.css')}}" rel="stylesheet">
    <link href="{{ URL::asset('vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css')}}" rel="stylesheet">
     <link href="{{ URL::asset('vendors/alertify/css/alertify.min.css')}}" rel="stylesheet">
 
	<link href="{{ URL::asset('vendors/alertify/css/default.min.css')}}" rel="stylesheet">
@endsection
@section('sidebar')
@parent
@endsection
@section('content')
			<div class="x_panel">
                  <div class="x_title">
                    <h2>Data Periode</h2>
                    
                    <div class="clearfix">
						<a href="{{url('addperiode')}}" class="btn btn-success pull-right"><i class="fa fa-plus"></i> Tambah</a>
					</div>
                  </div>
                  <div class="x_content">
				  <input type="hidden" name="_token" value="{{ csrf_token() }}" id='token'>
					<!--table-->
					<table id="datatable-mk" class="table table-striped table-bordered">
                            <thead>
                              <tr>
                                <th>Id Periode</th>
                                <th>Sistem</th>
                                <th>Tanggal awal</th>
								<th>Tanggal akhir</th>
															<th></th>
                              </tr>
                            </thead>
					</table>
					<!--endtable-->
                  </div>
               </div>
@endsection
@section('scripts')
<!-- Datatables -->
    <script src="{{ URL::asset('vendors/datatables.net/js/jquery.dataTables.min.js')}}"></script>
    <script src="{{ URL::asset('vendors/datatables.net-bs/js/dataTables.bootstrap.min.js')}}"></script>
    
    <script src="{{ URL::asset('vendors/datatables.net-responsive/js/dataTables.responsive.min.js')}}"></script>
    <script src="{{ URL::asset('vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js')}}"></script>
	<script src="{{ URL::asset('vendors/alertify/js/alertify.min.js')}}">
</script>
   <script type='text/javascript'>
			$(document).ready(function(){
			$('#datatable-mk').DataTable();
		});
   </script>
@endsection