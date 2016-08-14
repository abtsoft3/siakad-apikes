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
    	'semester',
        'kodemk'
    ];

    public function showdatamhs(){
    	$data = DB::table("mahasiswa")
    				->join("kelas_mahasiswa", "mahasiswa.nim", "=", "kelas_mahasiswa.nim")
                    ->join("kelasdosen", "kelas_mahasiswa.idkelas", "=", "kelasdosen.idkelas")
                    ->join("detailmatakuliah", "kelasdosen.iddosen", "=", "detailmatakuliah.iddosen")
    				->whereNotExists(function($query)
                     {
                        $query->select(DB::raw(1))
                        ->from("khs")
                        ->whereRaw("kelas_mahasiswa.idkelas = khs.idkelas and mahasiswa.nim = khs.nim and detailmatakuliah.kodemk = khs.kodemk and khs.semester = ".$this->semester);
                     })
    				->whereRaw("kelasdosen.iddosen = ".$this->iddosen." and kelas_mahasiswa.idkelas = ".$this->idkelas." and detailmatakuliah.kodemk = '".$this->kodemk."'")
                    ->select([
                                'mahasiswa.nim',
                                'mahasiswa.nama'
                            ]);
        return $data;
    }

	public function getksm($kat){
		
		if($kat==1){
			$data = DB::table('kelasdosen')
							 ->join("kelas", "kelasdosen.idkelas", "=", "kelas.idkelas")
                             ->join("detailmatakuliah", "kelasdosen.iddosen", "=", "detailmatakuliah.iddosen")
                             ->join("matakuliah", "detailmatakuliah.kodemk", "=", "matakuliah.kodemk")
							 ->whereNotExists(function($query)
		                     {
		                        $query->select(DB::raw(1))
		                        ->from('khs')
		                        ->whereRaw('kelasdosen.iddosen = khs.iddosen and kelas.idkelas = khs.idkelas and matakuliah.kodemk = khs.kodemk');
		                     })
		                     ->whereRaw('kelasdosen.iddosen = '.$this->iddosen)
		                     ->select([
		                     			'kelas.idkelas', 
		                     			'kelas.namakelas',
                                        'matakuliah.kodemk',
                                        'matakuliah.matakuliah',
                                        'matakuliah.semester',
                                        DB::raw('toRoman(matakuliah.semester) as romsem')
		                     		  ])->get();
		}
		return $data;
	}
}
