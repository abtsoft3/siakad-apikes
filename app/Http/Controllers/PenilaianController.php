<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use App\ModelPenilaian;

use Datatables;

class PenilaianController extends Controller
{
    public function add(){

    	$model = new ModelPenilaian;

    	$model->iddosen = '4';

    	$sem 	= $model->getsemester(1);
    	$kelas 	= $model->getkelas(1);

        $arrsemester['0'] = "Semester";
        foreach ($sem as $key => $csem) {
            $arrsemester[$csem->semester] = "Semester ".$csem->semester;
        }

        $arrkelas['0'] = "Kelas";
        foreach ($kelas as $key => $ckelas) {
            $arrkelas[$ckelas->idkelas] = $ckelas->namakelas;
        }

    	return view("penilaian.add_penilaian", ['arrsemester' => $arrsemester, 'arrkelas'=>$arrkelas]);
    }

    public function getdatamhs($kelas, $sem){

    	$model = new ModelPenilaian;

    	$model->iddosen 	= '4';   	
    	$model->idkelas		= $kelas;
    	$model->semester 	= $sem;

    	$datamhs = $model->showdatamhs();

    	return Datatables::of($datamhs)->make(true);
    }
}
