@extends('layouts.master_mahasiswa')
@section('title','Mahasiswa')
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
		<div class="col-lg-6 col-sm-6 col-xs-5">
		
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
		<div id="reportrange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
		   Last login :
				 <span> {{ date('d F, Y', strtotime(Auth::guard('usermahasiswas')->user()->updated_at)) }}</span> 
            </div>
	</div>		
 </div>
@endsection