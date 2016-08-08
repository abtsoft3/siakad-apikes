@extends('layouts.master_mahasiswa')
@section('title','Mahasiswa')
@section('css')
<link href="{{ URL::asset('build/css/jquery.fileupload.css')}}" rel="stylesheet">
<link href="{{ URL::asset('vendors/cropper-master/dist/cropper.min.css')}}" rel="stylesheet">
<style>
    .container-here {
      max-width: 960px;
      margin: 20px auto;
    }

    .img-container {
      width: 100%;
      max-height: 450px;
    }
	
	
    .img-container img {
      max-width: 100%;
    }

    .img-preview {
      overflow: hidden;
    }

    .col {
      float: left;
    }

    .col-6 {
      width: 50%;
    }

    .col-3 {
      width: 25%;
    }

    .col-2 {
      width: 16.7%;
    }

    .col-1 {
      width: 8.3%;
    }
	.fileinput-button {
    position: relative;
    overflow: hidden;
    display: inline-block;
	}

  </style>
@endsection
@section('sidebar')
@parent
@endsection
@section('content')
<div class="x_panel">
    <div class="x_title">
        <h2>Biodata</h2>
         <div class="filter">
           <div id="reportrange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
		   Create at :
            
                 <span> {{ date('d F, Y', strtotime(Auth::guard('usermahasiswas')->user()->created_at)) }}</span> 
				 
            </div>
          </div>
     <div class="clearfix"></div>
    </div>
    <div class="x_content">
		<div class="col-lg-5 col-sm-5 col-xs-5">
			<div  class="form form-horizontal" > 
			<div class="row">
					<div class="form-group">
						<label class="col-md-5 control-label">Nim</label>
						<div class="col-md-5">
							<label class="control-label">{{ Auth::guard('usermahasiswas')->user()->nim }}</label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-5 control-label">Nama</label>
						<div class="col-md-5">
							<label class="control-label">{{ Auth::guard('usermahasiswas')->user()->nama }}</label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-5 control-label">Tempat, Tanggal Lahir</label>
						<div class="col-md-5">
							<label class="control-label">{{ $model->tempatlahir }}, {{ $model->tanggallahir }}</label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-5 control-label">Nama Orang Tua</label>
						<div class="col-md-5">
							<label class="control-label">{{ $model->namaortu }}</label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-5 control-label">Asal Sekolah</label>
						<div class="col-md-5">
							<label class="control-label">{{ $model->asalsekolah }}</label>
						</div>
					</div>
				</div>
			</div>	
		</div>
		<!--div class="col-lg-5 col-sm-5 col-xs-5">

			<div class="container-here">
				<div class="row">
				  <div class="col col-6 img-container">
						<img src="#" alt="img-profile" style="max-width: 100%;" id="newimg" />
						<img id="image" style="max-width: 100%;" src="{{ URL::asset('images/cropper.jpg')}}" alt="profile-picture">
						{!! Form::open(array('url' => '/home/mahasiswa/TempUpload','id'=>'form-image','autocomplete'=>'off','enctype'=>'multipart/form-data')) !!}
						<span class="btn btn-success fileinput-button">
							<i class="fa fa-camera"></i>
								<span>Ganti</span>
								{!! Form::file('image_user',array('id'=>'image_user')) !!}
						</span>
						 {!! Form::close() !!}
						
				  </div>
				 
				</div>
			</div>
			
		</div-->
		<div id="reportrange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
		   Last login :
				 <span> {{ date('d F, Y', strtotime(Auth::guard('usermahasiswas')->user()->updated_at)) }}</span> 
            </div>
	</div>		
 </div>
 <!-- Modal -->
<div class="modal fade bs-example-modal-sm" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Upload</h4>
      </div>
      <div class="modal-body">
			
      </div>
      
    </div>
  </div>
</div>
@endsection
@section('scripts')
	<script src="{{ URL::asset('vendors/cropper-master/dist/cropper.min.js')}}"></script>
	<script type="text/javascript">
	function readURL(input) {
		var a=$(input)[0].files;
		form = $('#form-image');
		var fd = new FormData(form);
		fd.append('image_user',a);
		console.log(fd);
		$.ajax({
		  url: $('#form-image').attr('action'),
		  data: fd,
		  processData: false,
		  contentType: false,
		  type: 'POST',
		  headers: {
			'X-CSRF-TOKEN': $('input[name="_token"]').val()
		 },
		  success: function(data){
			console.log(data);
		  }
		});/*
        if (a) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#image').remove();
				$('#newimg').attr('src', e.target.result);
            }

            reader.readAsDataURL($(input)[0].files[0]);
			check=1;
        }*/
    }
	
	$(document).ready(function(){
		
		$('#image_user').change(function(){
			readURL($(this));
			var image=document.getElementById('newimg');
			/*var cropper = new Cropper(image, {
				aspectRatio: 1,
				viewMode: 1,
				ready: function () {
				croppable = true;
				}
			});*/
		});
	});
	</script>
@endsection