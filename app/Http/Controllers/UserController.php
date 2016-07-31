<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\ModelUsersMahasiswa;
use App\ModelUsersDosen;
class UserController extends Controller
{
    //
	public function add_user_mahasiswa(){
		return view('user_mahasiswa.register');
	}
	
	public function store_user_mahasiswa(Request $request){
		
			$model = new ModelUsersMahasiswa;
			$model->nim = $request->nim;
			$model->nama = $request->nama;
			$model->email = $request->email;
			$model->password = $request->password;
			
			$model->save();
			$stat=1;
			
		
		return response()->json(['return' => $stat]);
	}
	
	public function add_user_dosen(){
		return view('user_dosen.register');
	}
	
	public function store_user_dosen(Request $request){
			$model_dosen = new ModelUsersDosen;
			$model_dosen->nidn = $request->nidn;
			$model_dosen->nama = $request->nama;
			$model_dosen->email = $request->email;
			$model_dosen->password = $request->password;
			
			$model_dosen->save();
			$stat=1;
	}
	
	
}
