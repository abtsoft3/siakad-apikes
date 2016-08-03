<?php

namespace App\Http\Controllers;

use App\Http\Requests;
use Illuminate\Http\Request;
class UserMahasiswaController extends Controller
{
    
	public function __construct()
    {
        $this->middleware('usermahasiswa');
    }
	public function index(){
		return view('menu_mahasiswa.index');
	}
}
