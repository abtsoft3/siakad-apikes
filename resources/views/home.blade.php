@extends('layouts.master')
@section('title','admin')
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
        <h2>Profile Pengguna</h2>
         <div class="filter">
           <div 
           id="reportrange" class="pull-right" 
           style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
           Create at :
            
                 <span> {{ date('d F, Y', strtotime(Auth::user()->created_at)) }}</span> 
                 
            </div>
          </div>
     <div class="clearfix"></div>
    </div>
    <div class="x_content">
        <div class="col-lg-5 col-sm-5 col-xs-5">
            <div  class="form form-horizontal" > 
            <div class="row">
                    <div class="form-group">
                        <label class="col-md-5 control-label">Nama</label>
                        <div class="col-md-5">
                            <label class="control-label">{{ Auth::user()->name }}</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-5 control-label">Email</label>
                        <div class="col-md-5">
                            <label class="control-label">{{ Auth::user()->email }}</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-5 control-label">Hak Akses</label>
                        <div class="col-md-5">
                            @if(Auth::user()->admin)
                                <label class="control-label">Administrator</label>
                            @else
                                <label class="control-label">Bukan Administrator</label>
                            @endif
                        </div>
                    </div>
                   
                </div>
            </div>  
        </div>
        <div class="col-lg-5 col-sm-5 col-xs-5">

            <div class="container-here">
                <div class="row">
                  <div class="col col-6 img-container">

                    @if (Auth::user()->imageuser===null)
                    <img class="img-rounded" style="max-width: 100%;" id="image" src="{{ URL::asset('images/user.png')}}" alt="profil-picture" >
                    @else
                    <img class="img-rounded" id="image" style="max-width: 100%;" src="data:image/jpg;base64,{{ Auth::user()->imageuser}}" alt="profile-picture">
                    
                    @endif
                        {!! Form::open(array('url' => '/home/admin/TempUpload','id'=>'form-image','autocomplete'=>'off','enctype'=>'multipart/form-data')) !!}
                        <span class="btn btn-success fileinput-button">
                            <i class="fa fa-camera"></i>
                                <span>Ganti</span>
                                <input type="hidden" name="id" id="id" 
                                value="{{ Auth::user()->id }}" />
                                {!! Form::file('image_user',array('id'=>'image_user')) !!}
                        </span>
                        <button class="btn btn-primary" id="btn-submit" type="submit" style="display:none;">
                            <i class="fa fa-send"></i> Simpan</button>
                         {!! Form::close() !!}
                        
                  </div>
                 
                </div>
            </div>
            
        </div>
        <div id="reportrange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
           Last login :
                 <span> {{ date('d F, Y', strtotime(Auth::user()->updated_at)) }}</span> 
            </div>
    </div>      
 </div>

@endsection
@section('scripts')
    <script src="{{ URL::asset('vendors/cropper-master/dist/cropper.min.js')}}"></script>
    <script type="text/javascript">
    function readURL(input) {
        var a=$(input)[0].files;
        
        if (a) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#image').attr('src', e.target.result);
            }

            reader.readAsDataURL($(input)[0].files[0]);
        }
    }
    
    $(document).ready(function(){
        
        $('#image_user').change(function(){
            readURL($(this));
            var image=document.getElementById('newimg');
            $('#btn-submit').show();
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