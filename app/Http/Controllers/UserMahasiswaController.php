<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;

class UserMahasiswaController extends Controller
{
    
	
	public function index(){
		return view('menu_mahasiswa.index');
	}
}
