@extends('layouts.app')

@section('title','MataKuliah')
@section('css')

 <link href="{{ URL::asset('vendors/bootstrapvalidator/dist/css/bootstrapValidator.min.css')}}" rel="stylesheet">
 
 <link href="{{ URL::asset('vendors/alertify/css/alertify.min.css')}}" rel="stylesheet">
 
 <link href="{{ URL::asset('vendors/alertify/css/default.min.css')}}" rel="stylesheet">
 
@endsection
@section('sidebar')
@parent
@endsection
@section('content')
			<div class="x_panel">
                  <div class="x_title">
                    <h2>Tambah Data MataKuliah</h2>
                    <a href="{{url('showmatakuliah')}}" class="btn btn-success pull-right"><i class="fa fa-list"></i> Tampilkan</a>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
				 
					<div class="col-lg-6 col-sm-6 col-xs-5">
						{!! Form::open(array('url' => '/storematakuliah','class'=>'form-horizontal','id'=>'form-matakuliah','autocomplete'=>'off')) !!}
							<div class="form-group" id="mkkd">
								{!! Form::label('kodemk','Kode MataKuliah',array('class' => 'col-sm-4 control-label')) !!}
								<div class="col-sm-5">
									{!! Form::text('kodemk',null,array('class' => 'form-control','maxlength'=>'6')) !!}
									<small id="status_kdmk"></small>
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('matakuliah','MataKuliah',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-7">
									{!! Form::text('matakuliah',null,array('class' => 'form-control')) !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('bobot','Bobot',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-3">
									{!! Form::text('bobot',2,array('class' => 'form-control','maxlength'=>'1')) !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('teori','Teori',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-3">
									{!! Form::text('teori',1,array('class' => 'form-control','maxlength'=>'1')) !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('praktek','Praktek',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-3">
									{!! Form::text('praktek',1,array('class' => 'form-control','maxlength'=>'1')) !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('kadep','Kadep',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-7">
									{!! Form::text('kadep',null,array('class' => 'form-control')) !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('semester','Semester',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-5">
									{!! Form::select('semester',$arrsemester,'Pilih',array('class' => 'form-control')) !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('bobotnilai','Bobot Nilai',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-3">
									{!! Form::text('bobotnilai',0,array('class' => 'form-control','maxlength'=>'2')) !!}
								</div>
							</div>
							
								<div class="form-group">
										<div class="col-lg-offset-4 col-sm-3">
										  <button id="btn-submit" type="submit" class="btn btn-success"><i class="fa fa-send"></i> Tambah</button>
										</div>
									  </div>
									  {!! Form::close() !!}
							</div>
					</div>
					
					
                  </div>
@endsection
@section('scripts')
<script src="{{ URL::asset('vendors/bootstrapvalidator/dist/js/bootstrapValidator.min.js')}}">
</script>
<script src="{{ URL::asset('vendors/alertify/js/alertify.min.js')}}">
</script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js" ></script>
<script type='text/javascript'>
	var checkkode=0;
	var fn_check_kodemk_exist = function(val){
		if(val==1){
			$('#mkkd').removeClass('has-success').addClass('has-error');
			$('[data-bv-icon-for="kodemk"]').removeClass('glyphicon glyphicon-ok').addClass('glyphicon glyphicon-remove')
			$('#status_kdmk').text('kode sudah ada!').css('color','#a94442');
			$('#btn-submit').prop('disabled',true);
		}else{
			$('#status_kdmk').text('');
			$('#btn-submit').prop('disabled',false);
		}
	}
	$(document).ready(function(){
		$('#kodemk').autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: "/kodemk_autocomplete",
                    type: 'POST',
                    data: {
                        term: $('#kodemk').val(),
						_token : $('input[name="_token"]').val()
                    },
                    dataType: 'json',
                    success: function (data) {
                        response($.map(data, function (obj) {
							checkkode=parseInt(obj);
							fn_check_kodemk_exist(parseInt(obj));
                        }));
                    }
                });
            },
			 messages: {
				noResults:'' ,
				results: function() {{
					}
				}
			},
            change: function (event, ui) {
				parseInt(checkkode);
            }
        });
		
		
		$('#form-matakuliah').bootstrapValidator({
				live: 'enabled',
				message: 'This value is not Valid',
				feedbackIcons: {
					valid: 'glyphicon glyphicon-ok',
					invalid: 'glyphicon glyphicon-remove',
					validating: 'glyphicon glyphicon-refresh'
				},
				excluded:'disabled',
				fields: {
					
					kodemk: {
						validators: {
							notEmpty: {
								message: 'Silahkan isi kode'
							}
							
						}
					},
					matakuliah: {
						validators: {
							notEmpty: {
								message: 'Silahkan isi matakuliah'
							}
						}
					},
					bobot: {
						validators: {
							notEmpty: {
								message: 'Silahkan isi bobot'
							},
							 numeric: {
								message: 'bobot salah',
								
								thousandsSeparator: ',',
								decimalSeparator: '.'
							}	
						}
					},
					
					teori: {
						validators: {
							notEmpty: {
								message: 'Silahkan isi teori'
							},
							numeric: {
								message: 'teori salah',
								
								thousandsSeparator: ',',
								decimalSeparator: '.'
							}	
						}

					},
					praktek:{
						validators:{
							notEmpty: {
								message: 'Silahkan isi praktek'
							},
							numeric: {
								message: 'praktek salah',
								
								thousandsSeparator: ',',
								decimalSeparator: '.'
							}	
						}
					},
					kadep:{
						validators:{
							notEmpty:{
								message: 'Silahkan isi kadep'
							}	
						}
					},
					semester:{
						validators:{
							notEmpty: {
								message: 'Silahkan isi semester'
							}
						}
					},
					bobotnilai:{
						validators:{
							notEmpty: {
								message: 'Silahkan isi bobot nilai'
							},
							numeric: {
								message: 'bobot nilai salah',
								
								thousandsSeparator: ',',
								decimalSeparator: '.'
							}	
						}
					}
				}
			}).on('success.form.bv', function (e) {
        // Prevent form submission
				e.preventDefault();
				// Get the form instance
				var $form = $(e.target);
				// Get the BootstrapValidator instance
				var bv = $form.data('bootstrapValidator');
				// Use Ajax to submit form data
				
				//formData.append('file','file);
				var data = $form.serialize();
				$('#form-matakuliah input').attr("disabled", "disabled");
				$.ajax({
					type: 'POST',
					url: $form.attr('action'),
					data: data,
					dataType: 'json',
					success: function (data) {
						
							var returndata=parseInt(data.return);
							if(returndata==1){
								alertify.success('Data Berhasil Disimpan');
							}else{
								alertify.alert("Error ","Data Input Tidak Valid");
							}
							return false;
						},
						error: function (xhr,textStatus,errormessage) {
							alertify.alert("Kesalahan! ","Error !!"+xhr.status+" "+textStatus+" "+"Tidak dapat mengirim data!");
						},
						complete: function () {
							$('#form-matakuliah').bootstrapValidator('resetForm',true);
							$('#btn-submit').removeAttr('disabled');
							$('#form-matakuliah input').removeAttr("disabled");
							$('#bobot').val(2);
							$('#teori,#praktek').val(1);
							$('#bobotnilai').val(0);
						}
					});
				});
		});
</script>
@endsection