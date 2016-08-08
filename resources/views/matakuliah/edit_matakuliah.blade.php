@extends('layouts.master')

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
                    <a href="{{url('/home/showmatakuliah')}}" class="btn btn-success pull-right"><i class="fa fa-list"></i> Tampilkan</a>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
				 
					<div class="col-lg-6 col-sm-6 col-xs-5">
						{!! Form::open(array('url' => '/home/updatematakuliah','class'=>'form-horizontal','id'=>'form-matakuliah','autocomplete'=>'off')) !!}
							<div class="form-group">
								{!! Form::label('kodemk','Kode MataKuliah',array('class' => 'col-sm-4 control-label')) !!}
								<div class="col-sm-5">
									{!! Form::text('kodemk',$matakuliah->kodemk,array('class' => 'form-control','readonly'=>'true')) !!}
									<span id="status_kdmk"></span>
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('matakuliah','MataKuliah',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-7">
									{!! Form::text('matakuliah',$matakuliah->matakuliah,array('class' => 'form-control')) !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('bobot','Bobot',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-3">
									{!! Form::text('bobot',$matakuliah->bobot,array('class' => 'form-control','maxlength'=>'1')) !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('teori','Teori',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-3">
									{!! Form::text('teori',$matakuliah->teori,array('class' => 'form-control','maxlength'=>'1')) !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('praktek','Praktek',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-3">
									{!! Form::text('praktek',$matakuliah->praktek,array('class' => 'form-control','maxlength'=>'1')) !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('kadep','Kadep',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-7">
									{!! Form::text('kadep',$matakuliah->kadep,array('class' => 'form-control')) !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('semester','Semester',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-5">
									{!! Form::select('semester',$arrsemester,$matakuliah->semester,array('class' => 'form-control')) !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('bobotnilai','Bobot Nilai',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-3">
									{!! Form::text('bobotnilai',$matakuliah->bobotnilai,array('class' => 'form-control','maxlength'=>'2')) !!}
								</div>
							</div>
							
								<div class="form-group">
										<div class="col-lg-offset-4 col-sm-3">
										  <button id="btn-submit" type="submit" class="btn btn-success"><i class="fa fa-send"></i> Simpan</button>
										</div>
									  </div>
									  {!! Form::close() !!}
							</div>
					</div>
					
					
                  </div>
               </div>
@endsection
@section('scripts')
<script src="{{ URL::asset('vendors/bootstrapvalidator/dist/js/bootstrapValidator.min.js')}}">
</script>
<script src="{{ URL::asset('vendors/alertify/js/alertify.min.js')}}">
</script>
<script type='text/javascript'>
	$(document).ready(function(){
		
		
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
								alertify.confirm('Berhasil',"Data Berhasil diupdate", function () {
									window.location.href='/home/showmatakuliah';
									},function () {
									window.location.href='/home/showmatakuliah';
									});	
								
							}else{
								alertify.alert("Error ","Data Input Tidak Valid");
							}
							return false;
						},
						error: function (xhr,textStatus,errormessage) {
							alertify.alert("Kesalahan! ","Error !!"+xhr.status+" "+textStatus+" "+"Tidak dapat mengirim data!");
						},
						complete: function () {
							$('#btn-submit').removeAttr('disabled');
							$('#form-matakuliah input').removeAttr("disabled");
						}
					});
				});
		});
</script>
@endsection