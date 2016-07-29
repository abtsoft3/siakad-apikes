<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use DB;

class DaftarKrsModel extends Model
{

    public $nim;
    public $semester;

    protected $table = 'krs';

    public function showkrs(){
	
    	$data = $this->join('mahasiswa', 'krs.nim', '=', 'mahasiswa.nim')
    				 ->join('matakuliah', 'krs.kodemk', '=', 'matakuliah.kodemk')
    				 ->where('krs.nim', '=', $this->nim)
                     ->where('matakuliah.semester', '=', $this->semester)
    				 ->select([
    				     		'matakuliah.kodemk',
    				     		'matakuliah.matakuliah',
    				     		'matakuliah.bobot',
                                 DB::raw('matakuliah.semester as sem'),
    				     		 DB::raw('year(krs.tanggal) as tahun'),
    				     		'krs.keterangan'
    				     	  ])->get();
    	return $data;
    }

    public function showmahasiswa(){
    
        $data = DB::table('mahasiswa')
                         ->join('detailmahasiswa', 'mahasiswa.nim', '=', 'detailmahasiswa.nim')
                         ->join('angkatan', 'detailmahasiswa.idangkatan', '=', 'angkatan.idangkatan')
                         ->where('mahasiswa.nim', '=', $this->nim)
                         ->select([
                                    'mahasiswa.nim',
                                    'mahasiswa.nama',
                                    'angkatan.angkatan',
                                    'angkatan.tahun'
                                ])->get();
        
        return $data;
    }

    public function getsemester(){
        $data = DB::table('krs')
                     ->join('matakuliah', 'krs.kodemk', '=', 'matakuliah.kodemk')
                     ->where('krs.nim', '=', $this->nim)
                     ->select(['matakuliah.semester'])->distinct()->get();
        return $data;
    }
    
}
