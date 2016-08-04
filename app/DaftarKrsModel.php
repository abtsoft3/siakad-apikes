<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use DB;

class DaftarKrsModel extends Model
{

    //public $nim;
    public $semester;

    protected $table = 'krs';

    protected $filltable=[
        
        'nim',
        'kodemk',
        'keterangan'
    ];

   

   /* public function simpan(){
        $simpan = DB::insert('insert into krs (nim, kodemk, keterangan) values (?, ?, ?)', [1=>$this->nim, 2=>$this->kodemk, 3 => $this->keterangan]);
        return simpan;
    }*/

    public function showmk(){

        $data = DB::table('matakuliah')
                     ->whereNotExists(function($query)
                     {
                        $query->select(DB::raw(1))
                        ->from('krs')
                        ->whereRaw('matakuliah.kodemk = krs.kodemk and krs.nim = '.$this->nim);
                     })
                     ->where('matakuliah.semester', '=', $this->semester)
                     ->select([
                                'matakuliah.kodemk',
                                'matakuliah.matakuliah',
                                'matakuliah.bobot',
                                DB::raw('matakuliah.semester as sem')
                              ]);
        return $data;
    }

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

    public function getsemester($kat){
        //1 = untuk form add krs
        //2 = untuk view krs
        if($kat==1){
            $data = DB::table('matakuliah')
                     ->whereNotExists(function($query)
                     {
                        $query->select(DB::raw(1))
                        ->from('krs')
                        ->whereRaw('matakuliah.kodemk = krs.kodemk and krs.nim = '.$this->nim);
                     })
                     ->select(['matakuliah.semester'])->distinct()->get();
        }else{

            $data = DB::table('krs')
                     ->join('matakuliah', 'krs.kodemk', '=', 'matakuliah.kodemk')
                     ->where('krs.nim', '=', $this->nim)
                     ->select(['matakuliah.semester'])->distinct()->get();
        }
        
        return $data;
    }

    public function toroman($num){
        $n = intval($num); 
    $res = ''; 

    /*** roman_numerals array  ***/ 
    $roman_numerals = array( 
        'M'  => 1000, 
        'CM' => 900, 
        'D'  => 500, 
        'CD' => 400, 
        'C'  => 100, 
        'XC' => 90, 
        'L'  => 50, 
        'XL' => 40, 
        'X'  => 10, 
        'IX' => 9, 
        'V'  => 5, 
        'IV' => 4, 
        'I'  => 1); 

    foreach ($roman_numerals as $roman => $number){ 
        /*** divide to get  matches ***/ 
        $matches = intval($n / $number); 

        /*** assign the roman char * $matches ***/ 
        $res .= str_repeat($roman, $matches); 

        /*** substract from the number ***/ 
        $n = $n % $number; 
    } 

    /*** return the res ***/ 
    return $res; 
    }

    public $timestamps = false;
     
}
