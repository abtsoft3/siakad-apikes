<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

use DB;

class ModelPenilaian extends Model
{

	//public $idkelas;

    protected $table = 'khs';

    protected $filltable = [
    	'nim',
    	'iddosen',
    	'semester',
        'kodemk',
        'idkelas'
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
        else{

            $data = DB::table('kelasdosen')
                             ->join("kelas", "kelasdosen.idkelas", "=", "kelas.idkelas")
                             ->join("detailmatakuliah", "kelasdosen.iddosen", "=", "detailmatakuliah.iddosen")
                             ->join("matakuliah", "detailmatakuliah.kodemk", "=", "matakuliah.kodemk")
                             ->whereExists(function($query)
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

    public function showpenilaian(){
        $data = $this->join("mahasiswa", "khs.nim", "=", "mahasiswa.nim")
                     ->join("kelas", "khs.idkelas", "=", "kelas.idkelas")
                     ->join("matakuliah", "khs.kodemk", "=", "matakuliah.kodemk")
<<<<<<< HEAD
                     ->whereRaw("khs.idkelas = ".$this->idkelas." and khs.semester = ".$this->semester." and khs.kodemk = '".$this->kodemk."'")
=======
                     ->whereRaw("khs.idkelas = ".$this->kelas." and khs.semester = ".$this->semester." and khs.kodemk = ".$this->kodemk)
>>>>>>> 289ef8c4e0c6e5481a994b0bcb5f6e1bc91457c4
                     ->select([
                                'mahasiswa.nim',
                                'mahasiswa.nama',
                                'khs.absensi',
                                'khs.seminar',
                                'khs.tugas',
                                'khs.midsm',
                                'khs.nsem',
<<<<<<< HEAD
                                DB::raw('fhitungakhir(khs.absensi, khs.seminar, khs.tugas, khs.midsm, khs.nsem) as akhir'),
                                DB::raw('fnilaihuruf(fhitungakhir(khs.absensi, khs.seminar, khs.tugas, khs.midsm, khs.nsem)) as nilaihuruf'),
                                'khs.keterangan'
                              ])
                     ->orderBy('mahasiswa.nim', 'asc')->get();
=======
                                'khs.keterangan'
                              ]);
>>>>>>> 289ef8c4e0c6e5481a994b0bcb5f6e1bc91457c4
        return $data;
    }
}
