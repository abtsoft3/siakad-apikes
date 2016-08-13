<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use App\UserMahasiswa;

class UpdateAllUserMahasiswaController extends Controller
{
    //
    public function showform()
    {
    	return view('user_mahasiswa.update_all_usermahasiswa');

    }

    public function postUpdate(Request $request)
    {
    	
    }
}
