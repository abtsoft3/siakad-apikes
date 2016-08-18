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
<<<<<<< HEAD
        <a href="{{url('/home/addpenilaian')}}" class="btn btn-success pull-right"><i class="fa fa-plus"></i> Tambah</a>
=======
        <a href="{{url('/home/showkelasdosen')}}" class="btn btn-success pull-right"><i class="fa fa-plus"></i> Tambah</a>
>>>>>>> 289ef8c4e0c6e5481a994b0bcb5f6e1bc91457c4
      </div>
  </div>
  <div class="x_content">
          
  <!--table-->
  {!! Form::open(array('url' => '/home/addkelasdosen', 'id'=>'form-kelasdosen')) !!}
<<<<<<< HEAD
    <table id="datatable-kelasdosen" class="table table-striped table-bordered" width="100%">
=======
    <table id="datatable-kelasdosen" class="table table-striped table-bordered">
>>>>>>> 289ef8c4e0c6e5481a994b0bcb5f6e1bc91457c4
      <thead>
        <tr>
        <th colspan="11">
           <div class="form-horizontal">
            
              <div class="form-group">
                <!-- {!! Form::label('kelas','Kelas',array('class' => 'col-sm-4 control-label')) !!} -->
                    <div class="col-sm-4">
                      {!! Form::select('kelas', $arrkelas, '0',array('class' => 'form-control', 'style' => 'width:130px;')) !!}
                    </div>
              </div>

              <div class="form-group">
                <!-- {!! Form::label('semester','Semester',array('class' => 'col-sm-4 control-label')) !!} -->
                    <div class="col-sm-4">
                      {!! Form::select('semester', $arrsemester, '0',array('class' => 'form-control', 'style' => 'width:130px;')) !!}

                    </div>
              </div>

              <div class="form-group">
               <!--  {!! Form::label('matkul','Mata Kuliah',array('class' => 'col-sm-4 control-label')) !!} -->
                    <div class="col-sm-4">
                    {!! Form::select('matkul', $arrmatkul, '0',array('class' => 'form-control', 'style' => 'width:200px;')) !!}
                    </div>
              </div>

            </div>
          </th>
        </tr>
        <tr>
          <th width="3%">No</th>
          <th>Nim</th>
<<<<<<< HEAD
          <th width="20%">Nama</th>
=======
          <th>Nama</th>
>>>>>>> 289ef8c4e0c6e5481a994b0bcb5f6e1bc91457c4
          <th>Absensi</th>
          <th>Seminar</th>
          <th>Tugas</th>
          <th>MID SM</th>
<<<<<<< HEAD
          <th>UAS</th>
          <th>Akhir</th>
          <th>Nilai Huruf</th>
=======
          <th>Semester</th>
          <th>Akhir</th>
          <th>Nilaihuruf</th>
>>>>>>> 289ef8c4e0c6e5481a994b0bcb5f6e1bc91457c4
          <th>Keterangan</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
<<<<<<< HEAD
          <!-- <th colspan="11"><button id="btn-submit" type="button" class="btn btn-success pull-left"><i class="fa fa-print"></i> Cetak</button> </th>     -->      
=======
          <th colspan="11"><button id="btn-submit" type="button" class="btn btn-success pull-left"><i class="fa fa-print"></i> Cetak</button> </th>          
>>>>>>> 289ef8c4e0c6e5481a994b0bcb5f6e1bc91457c4
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

     

      var idkelas;
      var sem;
      var matkul;

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
                  {data: 'absensi',  name: 'absensi'},
                  {data: 'seminar',  name: 'seminar'},
                  {data: 'tugas',  name: 'tugas'},
                  {data: 'midsm',  name: 'midsm'},
                  {data: 'nsem',  name: 'nsem'},
                  {data: 'akhir',  name: 'akhir'},
                  {data: 'nilaihuruf',  name: 'nilaihuruf'},
                  {data: 'keterangan',  name: 'keterangan'},
              ],
              aoColumnDefs: [
              //{ "visible": false, "aTargets": 1 },
              {"bSortable" : false, "aTargets": 0 },
              { aTargets  : [ -1 ] }

              ],
              
              aaSorting: [[ 1, 'asc' ]]

          });

<<<<<<< HEAD
        var sbody = $('#datatable-kelasdosen thead');
=======
        /*var sbody = $('#datatable-kelasdosen thead');
>>>>>>> 289ef8c4e0c6e5481a994b0bcb5f6e1bc91457c4
        sbody.on('change','.form-control',function(){

              idkelas = $('#kelas').val();
              sem     = $('#semester').val();
              matkul  = $('#matkul').val();
              
<<<<<<< HEAD
              url = '{{"getdatakhs"}}/'+idkelas+'/'+sem+'/'+matkul;
              //alert(url);
              gentable.ajax.url(url).load(); 

          });

        /*var sdatabody = $('#datatable-kelasdosen tfoot');
=======
              url = '{{"getdatamhs"}}/'+idkelas+'/'+sem+'/'+matkul;
              gentable.ajax.url(url).load(); 

          });*/

        var sdatabody = $('#datatable-kelasdosen tfoot');
>>>>>>> 289ef8c4e0c6e5481a994b0bcb5f6e1bc91457c4
        sdatabody.on('click','#btn-submit',function(){
              
              var absensi;
              absensi = $('input[name="absensi[]"]').map(function() {
                return $(this).val();
              }).get();
              
              var seminar;
              seminar = $('input[name="seminar[]"]').map(function() {
                return $(this).val();
              }).get();

              var tugas;
              tugas = $('input[name="tugas[]"]').map(function() {
                return $(this).val();
              }).get();

              var midsm;
              midsm = $('input[name="midsm[]"]').map(function() {
                return $(this).val();
              }).get();

              var nsemester;
              nsemester = $('input[name="nsemester[]"]').map(function() {
                return $(this).val();
              }).get();

              var nim;
              nim = $('input[name="nim[]"]').map(function() {
                return $(this).val();
              }).get();

              var ket;
              ket = $('input[name="keterangan[]"]').map(function() {
                return $(this).val();
              }).get();

              $.ajax({
                type: 'POST',
                url: '{{"/home/addpenilaian"}}',
                data: {'nim':nim, 'matkul':matkul, 'absensi':absensi, 'seminar':seminar, 'tugas':tugas, 'midsm':midsm, 'nsemester':nsemester, 'ket':ket, 'idkelas':idkelas, 'sem':sem,  '_token' : $('input[name="_token"]').val()},
                dataType: 'json',
                success: function (data) {
                  
                    var returndata=data.return;
                    if(returndata==1){
                      alertify.success('Data Berhasil Disimpan');
                    }else{
                      alertify.alert("Error ","Data Input Tidak Valid ");
                    }
                    return false;
                  },
                  error: function (xhr,textStatus,errormessage) {
                    alertify.alert("Kesalahan! ","Error !!"+xhr.status+" "+textStatus+" "+"Tidak dapat mengirim data!");
                  },
                  complete: function () {
                    url = '{{"getdatamhs"}}/'+idkelas+'/'+sem+'/'+matkul;
                    gentable.ajax.url(url).load(); 
                  }
                });

<<<<<<< HEAD
          });*/
=======
          });
>>>>>>> 289ef8c4e0c6e5481a994b0bcb5f6e1bc91457c4



    });

    

   </script>
@endsection