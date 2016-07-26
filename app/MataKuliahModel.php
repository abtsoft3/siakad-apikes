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
	
	public static function validate($input){
		$rules = array(
			'kodemk' => 'Required|Max:6',
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
