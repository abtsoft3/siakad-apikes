<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;

class MahasiswaController extends Controller
{
    //
	
	public function index(){
		return view('show_mahasiswa');
	}
	
	public function add(){
		return view('add_mahasiswa');
	}
}
