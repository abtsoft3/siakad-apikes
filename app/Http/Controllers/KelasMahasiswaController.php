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
        return view('kelas_mahasiswa.show_kelas_mahasiswa');
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

    public function store(Request $request)
    {
        $stat=0;
        $model = array();
        $arrnim = $request->nim;
        foreach ($arrnim as $key => $value) {
            # code...
            $data = array(
                'kode_kelas'=>$request->kode_kelas,
                'nim'=>$value,
                'tahun_ajaran'=>$request->tahun_ajaran,
                'semester'=>$request->semester
            );
            array_push($model, $data);
        }
        
        $execute = ModelKelasMahasiswa::insert($model);
        if($execute)
        {
            $stat=1;
        }
        return response()->json(['return' => $stat]);
    }

    public function checking(Request $request)
    {
        $statreturn = 0;
        $nim = $request->get('nim');
        $semester = $request->get('semester');
        $kodekelas = $request->get('kodekelas');
        $tahun_ajaran = $request->get('tahun_ajaran');
        $where_group =['nim'=>$nim,'semester'=>$semester,'kode_kelas'=>$kodekelas,'tahun_ajaran'=>$tahun_ajaran];
        if (ModelKelasMahasiswa::where($where_group)->exists()) {
            $statreturn=1;
        }
        return response()->json(['return' => $statreturn]);
    }


}
