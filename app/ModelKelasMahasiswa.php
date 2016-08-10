<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ModelKelasMahasiswa extends Model
{
    //
     protected $table ='kelas_mahasiswa';
	public $timestamps = false;

	public static function validate($input){
		$rules = array(
			'nim' => 'Required',
			'kode_kelas' => 'Required'
		);
		return Validator::make($input, $rules);
	}
}
