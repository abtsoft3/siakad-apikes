<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use DB;

class DaftarKrsModel extends Model
{
	protected $table = 'krs';

    public function showkrs($nim, $semester){
	
    	$data = $this->join('mahasiswa', 'krs.nim', '=', 'mahasiswa.nim')
    				 ->join('matakuliah', 'krs.kodemk', '=', 'matakuliah.kodemk')
    				 ->where('matakuliah.semester', '=', $semester)
    				 ->select([
    				     		'mahasiswa.nim',
    				     		'matakuliah.kodemk',
    				     		'matakuliah.matakuliah',
    				     		'matakuliah.bobot',
    				     		 DB::raw('year(krs.tanggal) as tahun'),
    				     		'krs.keterangan'
    				     	  ])->get();
    	return $data;
    }

    public function showmahasiswa($nim){
    
        $data = DB::table('mahasiswa')
                         ->join('detailmahasiswa', 'mahasiswa.nim', '=', 'detailmahasiswa.nim')
                         ->join('angkatan', 'detailmahasiswa.idangkatan', '=', 'angkatan.idangkatan')
                         ->where('mahasiswa.nim', '=', $nim)
                         ->select([
                                    'mahasiswa.nim',
                                    'mahasiswa.nama',
                                    'angkatan.angkatan',
                                    'angkatan.tahun'
                                ]);
        return $data;
    }
}
