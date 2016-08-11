<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

class KelasDosenController extends Controller
{
    public function index(){
    	return view('kelas_dosen.add_kelasdosen');
    }
}
