<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

use DB;

class ModelPenilaian extends Model
{

	public $idkelas;

    protected $table = 'khs';

    protected $filltable = [
    	'nim',
    	'iddosen',
    	'semester'
    ];

    public function showdatamhs(){
    	$data = DB::table("dosen")
    				->join("kelasdosen", "dosen.iddosen", "=", "kelasdosen.iddosen")
    				->join("kelas_mahasiswa", "kelasdosen.idkelas", "=", "kelas_mahasiswa.idkelas")
    				->join("mahasiswa", "kelas_mahasiswa.nim", "=", "mahasiswa.nim")
    				->whereNotExists(function($query)
                     {
                        $query->select(DB::raw(1))
                        ->from("khs")
                        ->whereRaw("dosen.iddosen = khs.iddosen and mahasiswa.nim = khs.nim and kelas_mahasiswa.semester = khs.semester");
                     })
    				->whereRaw("kelasdosen.idkelas = ".$this->idkelas." and dosen.iddosen = ".$this->iddosen." and kelas_mahasiswa.semester = fromRoman('".$this->semester."')")
                    ->select([
                                'mahasiswa.nim',
                                'mahasiswa.nama'
                            ]);
        return $data;
    }

	public function getkelas($kat){
		
		if($kat==1){
			$data = DB::table('kelasdosen')
							 ->join("kelas", "kelasdosen.idkelas", "=", "kelas.idkelas")
							 ->whereNotExists(function($query)
		                     {
		                        $query->select(DB::raw(1))
		                        ->from('khs')
		                        ->whereRaw('kelasdosen.iddosen = khs.iddosen');
		                     })
		                     ->whereRaw('kelasdosen.iddosen = '.$this->iddosen)
		                     ->select([
		                     			'kelas.idkelas', 
		                     			'kelas.namakelas'
		                     		  ])->get();
		}
		return $data;
	}
    public function getsemester($kat){
        //1 = untuk form add nilai
        //2 = untuk view nilai
        if($kat==1){
            $data = DB::table('matakuliah')
                     ->whereNotExists(function($query)
                     {
                        $query->select(DB::raw(1))
                        ->from('khs')
                        ->whereRaw('matakuliah.kodemk = khs.kodemk and khs.iddosen = '.$this->iddosen);
                     })
                     ->select(DB::raw('toroman(matakuliah.semester) as semester'))->distinct()->get();
        }else{

            $data = DB::table('krs')
                     ->join('matakuliah', 'krs.kodemk', '=', 'matakuliah.kodemk')
                     ->where('krs.nim', '=', $this->nim)
                     ->select(DB::raw('toroman(matakuliah.semester) as semester'))->distinct()->get();
        }
        
        return $data;
    }
}
