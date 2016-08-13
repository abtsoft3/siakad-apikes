@extends('layouts.master')

@section('title','Penilaian Mahasiswa')
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
      <h2>Penilaian Mahasiswa</h2>
                    
      <div class="clearfix">
        <a href="{{url('/home/showkelasdosen')}}" class="btn btn-success pull-right"><i class="fa fa-list"></i> Tampilkan</a>
      </div>
  </div>
  <div class="x_content">
          
  <!--table-->
  {!! Form::open(array('url' => '/home/addkelasdosen', 'id'=>'form-kelasdosen')) !!}
    <table id="datatable-kelasdosen" class="table table-striped table-bordered">
      <thead>
        <tr>
        <th colspan="8">
           <div class="form-horizontal">
            
              <div class="form-group">
                <!-- {!! Form::label('kelas','Kelas',array('class' => 'col-sm-4 control-label')) !!} -->
                    <div class="col-sm-4">
                      {!! Form::select('kelas', $arrkelas, 'Kelas',array('class' => 'form-control', 'style' => 'width:130px;')) !!}
                    </div>
              </div>

              <div class="form-group">
                <!-- {!! Form::label('semester','Semester',array('class' => 'col-sm-4 control-label')) !!} -->
                    <div class="col-sm-4">
                      {!! Form::select('semester', $arrsemester, 'Semester',array('class' => 'form-control', 'style' => 'width:130px;')) !!}

                    </div>
              </div>

            </div>
          </th>
        </tr>
        <tr>
          <th width="3%">No</th>
          <th>Nim</th>
          <th>Nama</th>
          <th>Absensi</th>
          <th>Seminar</th>
          <th>Tugas</th>
          <th>MID SM</th>
          <th>Semester</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <th colspan="8"><button id="btn-submit" type="button" class="btn btn-success pull-left"><i class="fa fa-send"></i> Tambah</button> </th>          
        </tr> 
      </tfoot>
    </table>
    {!! Form::close() !!}
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

     

      /*$("#kelas").change(function() {

          url = '{{"getdatadosen"}}/'+$('#kelas').val();
          gentable.ajax.url(url).load(); 

      });*/

      gentable = $('#datatable-kelasdosen').DataTable({
              processing  : true,
              searching   : false,
              bInfo       : false,
              bPaginate   : false,
              ajax        : '',
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
                  {data: null,    name: 'no'},
                  {data: 'nim',   name: 'nim'},
                  {data: 'nama',  name: 'nama'},
                  {data: null,         name: 'keterangan',
                    orderable : false,
                    render: function ( data, type, row ) {
                        if ( type === 'display' ) {
                            return '<input type="text" name="absensi" id="absensi'+data.nim+'" class="form-control" size="4">';
                        }
                        return data;
                    },
                    className: "text-center",
                  },
                  {data: null,         name: 'keterangan',
                    orderable : false,
                    render: function ( data, type, row ) {
                        if ( type === 'display' ) {
                            return '<input type="text" name="seminar" id="seminar'+data.nim+'" class="form-control" size="4">';
                        }
                        return data;
                    },
                    className: "text-center",
                  },
                  {data: null,         name: 'keterangan',
                    orderable : false,
                    render: function ( data, type, row ) {
                        if ( type === 'display' ) {
                            return '<input type="text" name="tugas" id="tugas'+data.nim+'" class="form-control" size="4">';
                        }
                        return data;
                    },
                    className: "text-center",
                  },
                  {data: null,         name: 'keterangan',
                    orderable : false,
                    render: function ( data, type, row ) {
                        if ( type === 'display' ) {
                            return '<input type="text" name="midsm" id="midsm'+data.nim+'" class="form-control" size="4">';
                        }
                        return data;
                    },
                    className: "text-center",
                  },
                  {data: null,         name: 'keterangan',
                    orderable : false,
                    render: function ( data, type, row ) {
                        if ( type === 'display' ) {
                            return '<input type="text" name="nsemester" id="nsemester'+data.nim+'" class="form-control" size="4">';
                        }
                        return data;
                    },
                    className: "text-center",
                  },
              ],
              aoColumnDefs: [
              //{ "visible": false, "aTargets": 1 },
              {"bSortable" : false, "aTargets": 0 },
              { aTargets  : [ -1 ] }

              ],
              
              aaSorting: [[ 1, 'asc' ]]

          });

        var sbody = $('#datatable-kelasdosen thead');
        sbody.on('change','.form-control',function(){
            
            /*var iddosen;
            var isiiddosen;
                iddosen = $('.editor-active:checked').map(function(index, elem) {    
                  isiiddosen = $(elem).val();
                  return isiiddosen;
                }).get();*/
              
              var idkelas = $('#kelas').val();
              var sem     = $('#semester').val();
              
              url = '{{"getdatamhs"}}/'+$('#kelas').val()+'/'+$('#semester').val();
              gentable.ajax.url(url).load(); 

          });

    });

    

   </script>
@endsection