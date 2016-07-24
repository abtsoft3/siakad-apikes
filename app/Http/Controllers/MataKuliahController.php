<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;

class MataKuliahController extends Controller
{
    //
	public function index(){
		return view('show_matakuliah');
	}
	
	public function edit($kodemk){
		
	}
	
	public function add(){
		return view('add_matakuliah');
	}
}
