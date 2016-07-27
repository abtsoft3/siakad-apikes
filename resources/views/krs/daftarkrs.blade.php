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
      <h2>Kartu Rencana Studi</h2>
                    
      <div class="clearfix">
				<a href="{{url('')}}" class="btn btn-success pull-right"><i class="fa fa-plus"></i> Pengisian KRS</a>
			</div>
  </div>
  <div class="x_content">
    <div class="col-lg-6 col-sm-6 col-xs-5">
      <!-- form -->

    </div>

    <!--table-->
    <table id="datatable-krs" class="table table-striped table-bordered" width="100%">
      <thead>
      <tr>
          <th colspan="6">
           <div class="form-horizontal">
            {!! Form::open(array('url' => '/addmahasiswa', 'id'=>'form-daftarkrs')) !!}
              <div class="form-group">
                {!! Form::label('semester','Semester',array('class' => 'col-sm-4 control-label')) !!}
                    <div class="col-sm-4">
                      {!! Form::select('semester',$arrsemester,'Pilih',array('class' => 'form-control')) !!}
                    </div>
              </div>
            {!! Form::close() !!}
            </div>

            <div>
            <hr>
              <div class="col-md-7">
              <div class="col-md-4"><p>Tahun Akademik</p></div>
                <label id="vtahunakademik"></label>
              </div>

              <div class="col-md-7">
              <div class="col-md-4"><p>Nim</p></div>
               <div id="vnim">gsfg</div>
              </div>

              <div class="col-md-7">
              <div class="col-md-4"><p>Nama Mahasiswa</p></div>
                Nama
              </div>     

              <div class="col-md-7">
              <div class="col-md-4"><p>Angkatan / Tahun</p></div>
                Nama
              </div> 

              <div class="col-md-7">
              <div class="col-md-4"><p>Tingkat / Semester</p></div>
                Nama
              </div>  
            </div>

          </th>
        </tr>
        <tr>
          <th>No.</th>
          <th>Kode M.K</th>
          <th>Nama Mata Kuliah</th>
          <th>SKS</th>
          <th>Tahun</th>
          <th>Keterangan</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <th colspan="3">Total SKS Diambil : </th>          
          <th></th>
          <th colspan="2"></th>
        </tr>
      </tfoot>
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
      $("#semester").change(function() {
        
          $.get("./datamhs", function(data, status){
              alert($('#vnim').val());
               gentable.ajax.reload(); 
            },'json');
      });
			gentable = $('#datatable-krs').DataTable({
          processing  : true,
          searching   : false,
          bInfo       : false,
          bPaginate   : false,
          ajax: '{{url("datakrs")}}',

          fnDrawCallback: function ( oSettings ) {

            if ( oSettings.bSorted || oSettings.bFiltered )
            {
                for ( var i=0, iLen=oSettings.aiDisplay.length ; i<iLen ; i++ )
                {
                    $('td:eq(0)', oSettings.aoData[ oSettings.aiDisplay[i] ].nTr ).html( i+1 );
                }
            }
          },
          footerCallback: function ( row, data, start, end, display ) {
            var api = this.api(), data;

            var intVal = function ( i ) {
                return typeof i === 'string' ?
                    i.replace(/[\$,]/g, '')*1 :
                    typeof i === 'number' ?
                        i : 0;
            };

            total = api
                .column( 3 )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );

            $( api.column( 3 ).footer() ).html(
                 total 
            );
          },
          aoColumns: [
              {data: null,         name: 'no', bSortable : false,},
              {data: 'kodemk',     name: 'kodemk'},
              {data: 'matakuliah', name: 'matakuliah'},
              {data: 'bobot',      name: 'bobot'},
              {data: 'tahun',      name: 'tahun'},
              {data: 'keterangan', name: 'keterangan'}
          ],
          aoColumnDefs: [
            { 
              aTargets  : [ -1 ]
            }],
          
          aaSorting: [[ 1, 'asc' ]]
      });


      var sbody = $('#datatable-mahasiswa tbody');
      sbody.on('click','.edit',function(){
        var data = gentable.row($(this).parents('tr')).data();
        window.location.href='./editmahasiswa/'+data.nim;
      }).
      on('click','.delete',function(){
        var data = gentable.row($(this).parents('tr')).data();
        alertify.confirm("Anda Yakin Ingin menghapus data?", function (e) {
          if (e) {
            $.get("./deletemahasiswa/"+data.nim, function(data, status){
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