@extends('layouts.master')

@section('title','MataKuliah')
@section('css')
  <!-- Datatables -->
    <link href="{{ URL::asset('vendors/datatables.net-bs/css/dataTables.bootstrap.min.css')}}" rel="stylesheet">
    <link href="{{ URL::asset('vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css')}}" rel="stylesheet">
    
@endsection
@section('sidebar')
@parent
@endsection
@section('content')
			<div class="x_panel">
                  <div class="x_title">
                    <h2>Data Mahasiswa</h2>
                    
                    <div class="clearfix">
						<a href="{{url('addmahasiswa')}}" class="btn btn-success pull-right"><i class="fa fa-plus"></i> Tambah</a>
					</div>
                  </div>
                  <div class="x_content">
				  
					<!--table-->
					<table id="datatable-mahasiswa" class="table table-striped table-bordered">
                            <thead>
                              <tr>
                                <th>Nim</th>
                                <th>Nama</th>
                                <th>Tempat Lahir</th>
                                <th>Tanggal Lahir</th>
                                <th>Asal Sekolah</th>
                                <th>Nama Orang Tua</th>
                                <th>Aksi</th>
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
   <script type='text/javascript'>
		$(document).ready(function(){
			$('#datatable-mahasiswa').DataTable({
          processing: true,
          serverSide: true,
          ajax: '{{url("datamahasiswa")}}',
          columns: [
              {data: 'nim', name: 'nama'},
              {data: 'nama', name: 'nama'},
              {data: 'tempatlahir', name: 'tempatlahir'},
              {data: 'tanggallahir', name: 'tanggallahir'},
              {data: 'asalsekolah', name: 'asalsekolah'},
              {data: 'namaortu', name: 'namaortu'},
              {data: 'aksi', name: 'action'},
          ]
      });
		});
   </script>
@endsection