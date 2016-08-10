<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Validator;
class ModelKelas extends Model
{
    //
    protected $table ='kelas';
	public $timestamps = false;

	public static function validate($input){
		$rules = array(
			'kode_kelas' => 'Required',
			'nama_kelas' => 'Required'
		);
		return Validator::make($input, $rules);
	}
}
