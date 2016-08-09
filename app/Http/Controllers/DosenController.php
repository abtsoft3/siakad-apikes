<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

class DosenController extends Controller
{
    //
	public function index(){
		return ('dosen.show_dosen');
	}
	
	public function add(){

		$arrjeniskelamin =array('L'=>'Perempuan','P'=>'Laki-laki');

		$arrAgama = array(
			'Islam'=>'Islam',
			'Kristen'=>'Kristen',
			'Katolik'=>'Katolik',
			'Hindu'=>'Hindu',
			'Buddha'=>'Buddha'
			);
		$pendidikan =array(
				'S1'=>'S1',
				'S2'=>'S2',
				'S3'=>'S3'
			);
		return view('dosen.add_dosen',compact('arrjeniskelamin','arrAgama','pendidikan'));
	}

	public function edit()
	{

	}

	public function store()
	{

	}

	public function update()
	{

	}

}
