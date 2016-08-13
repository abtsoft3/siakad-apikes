@extends('layouts.master')

@section('title','Kelas Dosen')
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
      <h2>Tambah Kelas Dosen</h2>
                    
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
        <th colspan="4">
           <div class="form-horizontal">
            
              <div class="form-group">
                {!! Form::label('kelas','Kelas',array('class' => 'col-sm-4 control-label')) !!}
                    <div class="col-sm-4">
                      {!! Form::select('kelas', $arrkelas, 'Pilih',array('class' => 'form-control', 'style' => 'width:130px;')) !!}
                    </div>
              </div>
    
            </div>
          </th>
        </tr>
        <tr>
          <th width="5%">{!! Form::checkbox('checkall',null,null, array('id'=>'checkall')) !!}</th>
          <th>Iddosen</th>
          <th width="30%">NIDN</th>
          <th>Nama</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <th colspan="4"><button id="btn-submit" type="button" class="btn btn-success pull-left"><i class="fa fa-send"></i> Tambah</button> </th>          
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

     

      $("#kelas").change(function() {

          url = '{{"getdatadosen"}}/'+$('#kelas').val();
          gentable.ajax.url(url).load(); 

      });

      gentable = $('#datatable-kelasdosen').DataTable({
              processing  : true,
              
              ajax        : '',

              aoColumns: [
                  {
                    data:   null,
                    orderable : false,
                    mRender: function ( data, type, row ) {
                        if ( type === 'display' ) {
                          return '<input type="checkbox" name="iddosen" id="iddosen" class="editor-active" value="'+data.iddosen+'"">';
                        }
                        return data;
                    },
                    className: "text-center",

                  },
                  {data: 'iddosen', name: 'iddosen'},
                  {data: 'nidn',    name: 'nidn'},
                  {data: 'nama',    name: 'nama'}
              ],
              aoColumnDefs: [
              { "visible": false, "aTargets": 1  },
              { aTargets  : [ -1 ] }

              ],
              
              aaSorting: [[ 1, 'asc' ]]

          });

        var sbody = $('#datatable-kelasdosen tfoot');
        sbody.on('click','#btn-submit',function(){
          
            var iddosen;
            var isiiddosen;
                iddosen = $('.editor-active:checked').map(function(index, elem) {    
                  isiiddosen = $(elem).val();
                  return isiiddosen;
                }).get();
              
              var idkelas = $('#kelas').val();
              
              $.ajax({
                type: 'POST',
                url: "{{ url('/home/addkelasdosen') }}",
                data: {'idkelas':idkelas, 'iddosen':iddosen, '_token' : $('input[name="_token"]').val()},
                dataType: 'json',
                success: function (returndata) {

                    if(parseInt(returndata.return)==1){
                      alertify.success('data berhasil ditambahkan');
                    }else{
                      alertify.alert('data gagal ditambahkan');
                    }
                    return false;
                },
                error: function (xhr,textStatus,errormessage) {
                    alertify.alert("Kesalahan! ","Error !!"+xhr.status+" "+textStatus+" "+"Tidak dapat mengirim data!");
                },
                complete: function () {
                    url = '{{"getdatadosen"}}/'+$('#kelas').val();
                    gentable.ajax.url(url).load(); 
                }
              });
          });

        var shead = $('#datatable-kelasdosen thead');
        shead.on('click', '#checkall', function(){
          var cells = gentable.cells( ).nodes();
           $( cells ).find(':checkbox').prop('checked', $(this).is(':checked'));
            
        });

    });

    

   </script>
@endsection