<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests\MahasiswaRequests;

use App\ModelMahasiswa;

use Datatables;

use DB;

class MahasiswaController extends Controller
{
    //
	
	public function index(){
		return view('mahasiswa.show_mahasiswa');
	}
	
	public function add(){
		return view('mahasiswa.add_mahasiswa');
	}

	public function store(MahasiswaRequests $requests){

		$model = new ModelMahasiswa;

		$model->nim 			= $requests['nim'];
		$model->nama 			= $requests['nama'];
		$model->tempatlahir 	= $requests['tempatlahir'];
		$model->tanggallahir 	= $requests['tanggallahir'];
		$model->asalsekolah 	= $requests['asalsekolah'];
		$model->namaortu 		= $requests['namaortu'];
		$save = $model->save();

		if($save){
			\Session::flash('success', 'Data Berhasil Disimpan !' );
		}

		return redirect()->back();
	}

	public function show(){

		$model = new ModelMahasiswa;
		$data = $model->show();

		return Datatables::of($data)
		->addColumn('aksi', function ($data) {
                return '
                <a href="./editmahasiswa/'.$data->nim.'" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-edit"></i> Edit</a>
                <a href="./deletemahasiswa/'.$data->nim.'" class="btn btn-xs btn-danger"><i class="glyphicon glyphicon-remove"></i> Delete</a>';
            })->make(true);
	}

	public function edit($nim){

		$model = new ModelMahasiswa;

		$model->nim = $nim;
		$data = $model->edit();
		return view('mahasiswa.edit_mahasiswa', ['data'=>$data]);
	}

	public function update(MahasiswaRequests $requests){

		$model = new ModelMahasiswa;

		$data = $model->find($requests['nim']);

		$data->nim 			= $requests['nim'];
		$data->nama 		= $requests['nama'];
		$data->tempatlahir 	= $requests['tempatlahir'];
		$data->tanggallahir = $requests['tanggallahir'];
		$data->asalsekolah 	= $requests['asalsekolah'];
		$data->namaortu 	= $requests['namaortu'];

		$update = $data->save();

		if($update){
			\Session::flash('success', 'Data Berhasil Diubah !' );
		}

		return redirect()->back();
	}

	public function destroy($nim){
		
		$model = new ModelMahasiswa;
		$data  = $model->find($nim);
		$data->delete();

		return redirect()->back();
	}
}
