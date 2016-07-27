<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use App\DaftarKrsModel;

use Datatables;

class DaftarKrsController extends Controller
{
    public function index(){

    	$arrsemester = array(
    				'' =>'Pilih',
					'1'=>'Semester 1',
					'2'=>'Semester 2',
					'3'=>'Semester 3',
					'4'=>'Semester 4',
					'5'=>'Semester 5',
					'6'=>'Semester 6',
					'7'=>'Semester 7',
					'8'=>'Semester 8');

    	return view('krs.daftarkrs', ['arrsemester'=> $arrsemester]);
    }

    public function showkrs(){

    	$model = new DaftarKrsModel;

    	$data = $model->showkrs('1','1');
    	return Datatables::of($data)->make(true);
    }

    public function showmahasiswa(){

        $model = new DaftarKrsModel;

        $data = $model->showmahasiswa('1100000001');
        return Datatables::of($data)->make(true);
    }
}
