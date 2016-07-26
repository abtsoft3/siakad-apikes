@extends('layouts.master')

@section('title','Mahasiswa')
@section('css')
	<link href="{{ URL::asset('vendors/bootstrapdatetimepicker/bootstrap-datetimepicker.min.css')}}" rel="stylesheet">
@endsection
@section('sidebar')
@parent
@endsection
@section('content')
			<div class="x_panel">
                  <div class="x_title">
                    <h2>Tambah Data Mahasiswa</h2>
                    <a href="{{url('showmahasiswa')}}" class="btn btn-success pull-right"><i class="fa fa-list"></i> Tampilkan</a>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
					<div class="col-lg-6 col-sm-6 col-xs-5">

						@if(Session::has('success'))
						    <div class="alert alert-success">
						        {{ Session::get('success') }}
						    </div>
						@endif

						<!-- @if($errors->any())
						    <div class="alert alert-danger">
						        @foreach($errors->all() as $error)
						            <li>{{ $error }}</li>
						        @endforeach
						    </div>
						@endif -->

						{!! Form::open(array('url' => '/addmahasiswa','class'=>'form-horizontal')) !!}
							<div class="form-group">
								{!! Form::label('nim','Nim',array('class' => 'col-sm-4 control-label')) !!}
								<div class="col-sm-5">
									{!! Form::text('nim',null,array('class' => 'form-control','maxlength'=>'10')) !!}
									{!! $errors->first('nim', '<span class=text-danger>:message</span>') !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('nama','Nama Mahasiswa',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-7">
									{!! Form::text('nama',null,array('class' => 'form-control')) !!}
									{!! $errors->first('nama', '<span class=text-danger>:message</span>') !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('tempatlahir','Tempat Lahir',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-7">
									{!! Form::text('tempatlahir',null,array('class' => 'form-control')) !!}
									{!! $errors->first('tempatlahir', '<span class=text-danger>:message</span>') !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('tanggallahir','Tanggal Lahir',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-5">
									 <div class="input-group" id="dtpicker">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
											{!! Form::text('tanggallahir',null,array('class' => 'form-control')) !!}
											{!! $errors->first('tanggallahir', '<span class=text-danger>:message</span>') !!}
										</div>
									</div>
								</div>
								
								<div class="form-group">
									{!! Form::label('asalsekolah','Asal Sekolah',array('class' => 'col-sm-4 control-label')) !!}<div class="col-sm-7">
										{!! Form::text('asalsekolah',null,array('class' => 'form-control')) !!}
										{!! $errors->first('asalsekolah', '<span class=text-danger>:message</span>') !!}
									</div>
								</div>

								<div class="form-group">
									{!! Form::label('namaortu','Nama Orang Tua',array('class' => 'col-sm-4 control-label')) !!}<div class="col-sm-7">
										{!! Form::text('namaortu',null,array('class' => 'form-control')) !!}
										{!! $errors->first('namaortu', '<span class=text-danger>:message</span>') !!}
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
<script src="{{ URL::asset('vendors/bootstrapdatetimepicker/moment.min.js')}}">
	</script>
	<script src="{{ URL::asset('vendors/bootstrapdatetimepicker/moment-with-locales.min.js')}}">
	</script>
	<script src="{{ URL::asset('vendors/bootstrapdatetimepicker/bootstrap-datetimepicker.min.js')}}">
	</script>
   <script type='text/javascript'>
		$(document).ready(function(){
			$('#dtpicker').datetimepicker({
				format:'YYYY-MM-DD'
			});
		});
   </script>
@endsection