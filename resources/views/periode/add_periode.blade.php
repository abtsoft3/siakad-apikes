@extends('layouts.master')

@section('title','periode')
@section('css')
	<link href="{{ URL::asset('vendors/bootstrapdatetimepicker/bootstrap-datetimepicker.min.css')}}" rel="stylesheet">
@endsection
@section('sidebar')
@parent
@endsection
@section('content')
			<div class="x_panel">
                  <div class="x_title">
                    <h2>Tambah Data Periode</h2>
                    <a href="{{url('showperiode')}}" class="btn btn-success pull-right"><i class="fa fa-list"></i> Tampilkan</a>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
					<div class="col-lg-6 col-sm-6 col-xs-5">
						{!! Form::open(array('url' => '/create','class'=>'form-horizontal')) !!}
							<div class="form-group">
								{!! Form::label('idperiode','Id Periode',array('class' => 'col-sm-4 control-label')) !!}
								<div class="col-sm-5">
									{!! Form::text('nim',null,array('class' => 'form-control','maxlength'=>'5')) !!}
								</div>
							</div>
							
							<div class="form-group">
								{!! Form::label('sistem','Sistem',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-7">
									{!! Form::text('nama',null,array('class' => 'form-control')) !!}
								</div>
							</div>
							
											
							<div class="form-group">
								{!! Form::label('tglawal','Tanggal Awal',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-5">
									 <div class="input-group" id="dtpicker">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
											{!! Form::text('tglawal',null,array('class' => 'form-control')) !!}
										
									</div>
									</div>
								</div>
								
									<div class="form-group">
								{!! Form::label('tglakhir','Tanggal Akhir',array('class' => 'col-sm-4 control-label')) !!}	
								<div class="col-sm-5">
									 <div class="input-group" id="dtpicker1">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
											{!! Form::text('tglakhir',null,array('class' => 'form-control')) !!}
										
									</div>
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
				format:'DD-MM-YYYY'
			});
		});
		
		$(document).ready(function(){
			$('#dtpicker1').datetimepicker({
				format:'DD-MM-YYYY'
			});
		});
   </script>
@endsection