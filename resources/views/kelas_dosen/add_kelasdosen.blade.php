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
    <table id="datatable-kelasdosen" class="table table-striped table-bordered">
      <thead>
        <tr>
          <th></th>
          <th>Iddosen</th>
          <th>NIDN</th>
          <th>Nama</th>
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
      gentable = $('#datatable-kelasdosen').DataTable({
              processing  : true,
              searching   : false,
              bInfo       : false,
              bPaginate   : false,
              //ajax        : '{{"listkrs"}}/0',

              fnDrawCallback: function ( oSettings ) {

                if ( oSettings.bSorted || oSettings.bFiltered )
                {
                    for ( var i=0, iLen=oSettings.aiDisplay.length ; i<iLen ; i++ )
                    {
                        $('td:eq(0)', oSettings.aoData[ oSettings.aiDisplay[i] ].nTr ).html( i+1 );
                    }
                }
              },
              
              aoColumns: [
                  {
                    data:   null,
                    orderable : false,
                    render: function ( data, type, row ) {
                        if ( type === 'display' ) {
                          return '<input type="checkbox" name="idosen" id="idosen" class="editor-active" value="'+data.iddosen+'"">';
                        }
                        return data;
                    },
                    className: "dt-body-center",

                  },
                  {data: 'iddosen', name: 'iddosen'},
                  {data: 'nidn',    name: 'nidn'},
                  {data: 'nama',    name: 'nama'}
              ],
              aoColumnDefs: [
                { 
                   visible: false, 
                   targets: 1
                }],
              
              aaSorting: [[ 1, 'asc' ]]

          });
    });

    


   </script>
@endsection