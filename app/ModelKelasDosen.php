<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

use DB;

class ModelKelasDosen extends Model
{
    protected $table ='kelasdosen';

    protected $filltable=[
        'idkelasdosen',
        'iddosen',
        'kodekelas'
    ];

    public function datadosen(){
    	$data = DB::table('dosen')
                     ->whereNotExists(function($query)
                     {
                        $query->select(DB::raw(1))
                        ->from('kelasdosen')
                        ->whereRaw("dosen.iddosen = kelasdosen.iddosen and kelasdosen.idkelas = '".$this->idkelas."'");
                     })
                     ->select([
                                'dosen.iddosen',
                                'dosen.nidn',
                                'dosen.nama'
                              ]);
        return $data;
    }

    public function datakelas(){
    	$data = DB::table('kelas')
                     ->select([
                     			'idkelas',
                                'kodekelas',
                     			'namakelas'
                              ])->get();
        return $data;
    }

    public function showkelasdosen(){
    	$data = $this->join("dosen", "kelasdosen.iddosen", "=", "dosen.iddosen")
    				 ->join("kelas", "kelasdosen.idkelas", "=", "kelas.idkelas")
                     ->select([
                     			'kelasdosen.idkelasdosen',
                     			'dosen.nidn',
                     			'dosen.nama',
                     			'kelas.namakelas'
                              ])->get();
        return $data;
    }

    public function datakelasdosen(){
    	$data = $this->join("dosen", "kelasdosen.iddosen", "=", "dosen.iddosen")
    				 ->join("kelas", "kelasdosen.idkelas", "=", "kelas.idkelas")
    				 ->whereRaw("kelasdosen.idkelasdosen = ".$this->idkelasdosen)
                     ->select([
                     			'kelasdosen.idkelasdosen',
                     			'dosen.nidn',
                     			'dosen.nama',
                                'kelas.idkelas'
                              ])->get();
        return $data;
    }

    public $primaryKey  = 'idkelasdosen';

    public $timestamps  = false;
}
