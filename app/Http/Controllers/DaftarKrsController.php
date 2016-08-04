<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use App\DaftarKrsModel;

use Datatables;

use PDF;

use DB;

class DaftarKrsController extends Controller
{
    
    public function index(){

        $model = new DaftarKrsModel;

        $arrsemester = array();

        $model->nim         = '1100000001';
        
        $sem = $model->getsemester(1);

        $arrsemester['0'] = "Pilih";
        foreach ($sem as $key => $csem) {
            $arrsemester[$csem->semester] = "Semester ".$csem->semester;
        }
        return view('krs.add_krs',  ['arrsemester'=> $arrsemester]);
    }

    public function datamk($sem){
         $model = new DaftarKrsModel;
         $model->nim        = '1100000001';
         $model->semester   = $sem;
         $datamk = $model->showmk();
         /*foreach ($datamk as $key => $value) {
             echo $value->kodemk;
         }*/
         return Datatables::of($datamk)->make(true);
    }

    public function listkrs(){
        
        $model = new DaftarKrsModel;

        $arrsemester = array();

        $model->nim         = '1100000001';
        
        $sem = $model->getsemester(2);
       
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

     public function printkrs($sem){
        
        $model = new DaftarKrsModel;

        $model->nim = '1100000001';
        $model->semester = $sem;

        $datakrs = $model->showkrs();
        $datamhs = $model->showmahasiswa();

        $pdf = PDF::loadView('krs.show_krs', ['datamhs'=>$datamhs, 'datakrs'=>$datakrs, 'vts'=>$sem])
                    ->setPaper('a4')
                    ->setOrientation('potrait');

        return $pdf->stream();
    }

    public function store(Request $request){
        $stat = 0;
        $model = new DaftarKrsModel;
        $kodemk = $request['kdmk'];
        $ket    = $request['ket'];

        $vkdmk  = explode(',', $kodemk); 
        $vket   = explode(',', $ket);

        


        for($i=0; $i<count($vkdmk); $i++){
            $data [] = array(
                                'nim' => '1100000001',
                                'kodemk' => $vkdmk[$i],
                                'keterangan' => $vket[$i]
                            );
        }

        $save = $model->insert($data);
       
        if($save){
            $stat = 1;
        }
        else{
            $stat = 2;
        }

        return response()->json(['return' => $stat]);
    }
}
