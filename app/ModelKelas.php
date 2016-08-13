<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Validator;
class ModelKelas extends Model
{
    //
    protected $table ='kelas';
	public $timestamps = false;
	public $primaryKey = 'idkelas';

	public static function validate($input){
		$rules = array(
			'kodekelas' => 'Required',
			'namakelas' => 'Required'
		);
		return Validator::make($input, $rules);
	}
}
