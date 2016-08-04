@extends('layouts.master_mahasiswa')

@section('title','Mahasiswa')
@section('css')
	<link href="{{ URL::asset('vendors/bootstrapdatetimepicker/bootstrap-datetimepicker.min.css')}}" rel="stylesheet">

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
                    <h2>Profile</h2>
                   
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
					<div class="col-lg-6 col-sm-6 col-xs-5">
						<table class="table table-condensed">
							<tbody>
								<tr>
									<td>NIM</td><td>{{ Auth::guard('usermahasiswa')->user()->nim }}</td>
								</tr>
								<tr>
									<td>Nama</td><td>{{ Auth::guard('usermahasiswa')->user()->nama }}</td>
								</tr>
							</tbody>
						</table>
					</div>
					</div>
					
					
                  </div>
               </div>
@endsection
@section('scripts')
	<script src="{{ URL::asset('vendors/bootstrapdatetimepicker/moment.min.js')}}"></script>
	<script src="{{ URL::asset('vendors/bootstrapdatetimepicker/moment-with-locales.min.js')}}"></script>
	<script src="{{ URL::asset('vendors/bootstrapdatetimepicker/bootstrap-datetimepicker.min.js')}}"></script>
	
	<script src="{{ URL::asset('vendors/bootstrapvalidator/dist/js/bootstrapValidator.min.js')}}"></script>
	<script src="{{ URL::asset('vendors/alertify/js/alertify.min.js')}}"></script>
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js" ></script>

    <script type='text/javascript'>
		$(document).ready(function(){
			
		});
		
   </script>
@endsection