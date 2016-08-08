<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Validator;
class MataKuliahModel extends Model
{

    //
	protected $table ='matakuliah';
	protected $primaryKey ='kodemk';
	
	public $timestamps = false;
	
	protected $filltable=[
			'kodemk' ,
			'matakuliah',
			'bobot' ,
			'teori' ,
			'praktek'  ,
			'kadep' ,
			'bobotnilai'
    ];

    public function show(){
    	$data = $this->select(['*']);
    	return $data;
    }
	
	public static function validate($input){
		$rules = array(
			'kodemk' => 'Required',
			'matakuliah' => 'Required|Max:100',
			'bobot' => 'Required|Max:1',
			'teori' => 'Required|Max:1' ,
			'praktek' => 'Required|Max:1' ,
			'kadep' => 'Required|Max:100',
			'bobotnilai' => 'Required|Max:2'
		);
		
		return Validator::make($input, $rules);
	}
}
