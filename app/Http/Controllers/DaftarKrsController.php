<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use App\DaftarKrsModel;

use Datatables;

use PDF;

class DaftarKrsController extends Controller
{
    public function index(){
        
        $model = new DaftarKrsModel;

        $arrsemester = array();

        $model->nim         = '1100000001';
        
        $sem = $model->getsemester();
       
        $arrsemester['0'] = "Pilih";
        foreach ($sem as $key => $csem) {
            $arrsemester[$csem->semester] = "Semester ".$csem->semester;
        }
    	
    	return view('krs.list_krs', ['arrsemester'=> $arrsemester]);
    }

    public function showkrs($sem){

    	$model = new DaftarKrsModel;

        $cmhs = array();

        $model->nim = '1100000001';
        $model->semester = $sem;

        $datakrs = $model->showkrs();

        $datamhs = $model->showmahasiswa();       
        foreach ($datamhs as $name => $cdatamhs) {
            $cmhs['nim'] = $cdatamhs->nim;
            $cmhs['nama'] = $cdatamhs->nama;
            $cmhs['angkatan'] = $cdatamhs->angkatan;
            $cmhs['tahun'] = $cdatamhs->tahun;
        }

        return Datatables::of($datakrs)
        ->with($cmhs)
        ->make(true);

    }

     public function printkrs(){
        
        //$model = new DaftarKrsModel;

        $pdf = PDF::loadView('krs.show_krs')->setPaper('a4')->setOrientation('potrait');
        return $pdf->stream();
    }

}
