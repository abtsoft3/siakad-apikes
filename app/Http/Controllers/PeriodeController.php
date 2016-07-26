<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

class PeriodeController extends Controller
{
    //
	public function index(){
		return view('periode.show_periode');
	}
	
	public function add(){
		
		return view('periode.add_periode');
	}
}
