@extends('layouts.master')

@section('title','MataKuliah')
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
      <h2>Data Mahasiswa</h2>
                    
      <div class="clearfix">
				<a href="{{url('/home/addmahasiswa')}}" class="btn btn-success pull-right"><i class="fa fa-plus"></i> Tambah</a>
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
    <script src="{{ URL::asset('vendors/alertify/js/alertify.min.js')}}"></script>
    <script type='text/javascript'>
    var gentable=null;
		$(document).ready(function(){
			gentable = $('#datatable-mahasiswa').DataTable({
          processing: true,
          ajax: '{{url("/home/datamahasiswa")}}',
          columns: [
              {data: 'nim', name: 'nim'},
              {data: 'nama', name: 'nama'},
              {data: 'tempatlahir', name: 'tempatlahir'},
              {data: 'tanggallahir', name: 'tanggallahir'},
              {data: 'asalsekolah', name: 'asalsekolah'},
              {data: 'namaortu', name: 'namaortu'},
              {
              "className": "action text-center",
              "data": null,
              "bSortable": false,
              "defaultContent": "" +
              "<div class='btn-group' role='group'>" +
              "  <button class='edit  btn btn-primary btn-xs' rel='tooltip' data-toggle='tooltip' data-placement='left' title='Edit'><i class='fa fa-edit'></i></button>" +
              "  <button class='delete btn btn-danger btn-xs' rel='tooltip' data-toggle='tooltip' data-placement='right' title='Hapus'><i class='fa fa-trash-o'></i></button>" +
              "<button type=\"button\" class=\"btn btn-success btn-xs detail\" rel='tooltip' data-toggle='tooltip' data-placement='right' title='Detail'><i class='fa fa-list'></i>" +
              "<span class=\"sr-only\">Action</span></button>" +
              "</div>"
            }
          ]
      });

      var sbody = $('#datatable-mahasiswa tbody');
      sbody.on('click','.edit',function(){
        var data = gentable.row($(this).parents('tr')).data();
        window.location.href='/home/editmahasiswa/'+data.nim;
      }).
      on('click','.delete',function(){
        var data = gentable.row($(this).parents('tr')).data();
        alertify.confirm("Anda Yakin Ingin menghapus data?", function (e) {
          if (e) {
            $.get("/home/deletemahasiswa/"+data.nim, function(data, status){
              //alert(data)
                if(parseInt(data.return)==1){
                  alertify.success('Data berhasil dihapus');
                  gentable.ajax.reload();
                }else{
                  alertify.error('Gagal menghapus');
                }
                
            },'json');
          }
        });   
      });
      //tooltip
      $('body').tooltip({
        selector: '[rel=tooltip]'
      });

		});

    


   </script>
@endsection