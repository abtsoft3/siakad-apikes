<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use App\ModelMahasiswa;
class UserMahasiswaController extends Controller
{
    
	
	public function index($nim)
	{
	//	try{
			if(isset($nim)){
				$model = ModelMahasiswa::findOrfail($nim);
				return view('menu_mahasiswa.index')->with('model',$model);
		}
	//	}catch(Exception $e){
		//	return redirect('503');
		//}
		
		
	}
}
