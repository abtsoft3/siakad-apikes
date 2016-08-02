@extends('layouts.app')

@section('content')
 <div class="container">
      <div class="row">  
  <div class="col-md-offset-4 col-lg-offset-4 col-md-4 col-lg-4">
       <div class="panel panel-default">
       <div class="panel-body">
          <div class="page-header">
         <h3>Login Mahasiswa <i class="glyphicon glyphicon-user"></i></h3>
      </div>
      <form id="login-form" action="{{ url('/login-mahasiswa') }}" 
      method="post" accept-charset="utf-8" role="form">

         

         <div class="form-group{{ $errors->has('nim') ? ' has-error' : '' }}">
            <label for="nim">NIM</label>
            <div class="input-group">
               <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
			   {{ csrf_field() }}
               <input type="text" class="form-control" name="nim" id="nim" required />

                @if ($errors->has('nim'))
                    <span class="help-block">
                        <strong>{{ $errors->first('nim') }}</strong>
                    </span>
                @endif

            </div>
         </div>
         <div class="form-group">
            <label for="password">Password</label>
            <div class="input-group">
           <span class="input-group-addon"><span class="glyphicon glyphicon-star"></span></span>
           <input type="password" class="form-control" name="password" required />
        </div>
         </div>
         <hr/>
         
         <button type="submit" class="btn btn-primary" id="btn-submit">
            <span class="glyphicon glyphicon-lock"></span> Login</button>
         <a href="{{url('/')}}" class="btn btn-success">
            <span class="glyphicon glyphicon-chevron-left"></span> Kembali</a>
         <p>
        </p>

      </form>
       </div>
    </div>
    
     </div>
  </div>
    </div>
@endsection
