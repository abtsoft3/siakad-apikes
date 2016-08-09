<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use App\ModelKelas;
use App\ModelKelasMahasiswa;

class KelasMahasiswaController extends Controller
{
    //
    public function index()
    {

    }

    public function add()
    {
    	$arrsemester =array(
					'1'=>'Semester 1',
					'2'=>'Semester 2',
					'3'=>'Semester 3',
					'4'=>'Semester 4',
					'5'=>'Semester 5',
					'6'=>'Semester 6',
					'7'=>'Semester 7',
					'8'=>'Semester 8');
    	$datakelas = ModelKelas::pluck('nama_kelas','kode_kelas');

    	return view('kelas_mahasiswa.add_kelas_mahasiswa',compact('datakelas','arrsemester'));
    }


}
