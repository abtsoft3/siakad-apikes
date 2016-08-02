<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use Auth;
use App\UserMahasiswa;
class UserMahasiswaController extends Controller
{
    
	public function __construct()
    {
        $this->middleware('usermahasiswa');
    }
	public function index(){
		return view('menu_mahasiswa/index');
	}
}
