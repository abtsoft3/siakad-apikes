<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Validator;
use DB;

class ModelKelas extends Model
{
    //
    protected $table ='kelas';
	public $timestamps = false;
	public $primaryKey = 'idkelas';

	protected $filltable = [
    	'kodekelas',
    	'namakelas',
    	'iddosen'
    ];

	public static function validate($input){
		$rules = array(
			'kodekelas' => 'Required',
			'namakelas' => 'Required',
			'iddosen' => 'Required'
		);
		return Validator::make($input, $rules);
	}

	public static function showdosen(){
		
		$data = DB::table('dosen')
					->select([
								'iddosen',
								'nama'
						])->get();
		return $data;
	}
}
