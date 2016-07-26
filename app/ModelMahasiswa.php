<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ModelMahasiswa extends Model
{
    protected $table = 'mahasiswa';

    protected $filltable=[
    	'nim',
    	'nama',
    	'tempatlahir',
    	'tanggallahir',
    	'asalsekolah',
    	'namaortu'
    ];

    public function show(){
    	$data = $this->select(['*']);
    	return $data;
    }

    public function edit(){
        $data = $this->where(['nim'=>$this->nim])->get();
        return $data;
    }

    public $timestamps = false;

    public $primaryKey  = 'nim';
}
