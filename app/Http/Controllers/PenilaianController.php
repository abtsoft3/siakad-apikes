<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use App\ModelPenilaian;

use Datatables;

class PenilaianController extends Controller
{
    public function add($iddosen){

    	$model = new ModelPenilaian;

    	$model->iddosen = $iddosen;

    	//$sem 	= $model->getsemester(1);
    	$kelas 	= $model->getksm(1);
        //$matkul = $model->getsemester(1);

        /*$arrsemester['0'] = "Semester";
        foreach ($sem as $key => $csem) {
            $arrsemester[$csem->semester]   = "Semester ".$csem->semester;
            $arrmatkul[$csem->kodemk]       = $csem->matakuliah;
        }*/

        $arrkelas['0']      = "Kelas";
        $arrsemester['0']   = "Semester";
        $arrmatkul['0']     = "Mata Kuliah";

        foreach ($kelas as $key => $ckelas) {
            $arrkelas[$ckelas->idkelas] = $ckelas->namakelas;
            $arrmatkul[$ckelas->kodemk]       = $ckelas->matakuliah;
            $arrsemester[$ckelas->semester]   = "Semester ".$ckelas->romsem;
        }

       /* $arrmatkul['0']   = "Mata Kuliah";
        foreach ($matkul as $key => $cmatkul) {
            $arrmatkul[$cmatkul->kodemk] = $cmatkul->matakuliah;
        }*/

    	return view("penilaian.add_penilaian", ['arrsemester' => $arrsemester, 'arrkelas'=>$arrkelas, 'arrmatkul'=>$arrmatkul]);
    }

    public function getdatamhs($iddosen,$kelas, $sem, $matkul){

    	$model = new ModelPenilaian;

    	$model->iddosen 	= $iddosen;   	
    	$model->idkelas		= $kelas;
    	$model->semester 	= $sem;
        $model->kodemk      = $matkul;

    	$datamhs = $model->showdatamhs();

    	return Datatables::of($datamhs)->make(true);
    }

    public function store(Request $requests){

        $model = new ModelPenilaian;

        $dosen      = '4';
        $nim        = $requests->nim;
        $absensi    = $requests->absensi;
        $seminar    = $requests->seminar;
        $tugas      = $requests->tugas;
        $midsm      = $requests->midsm;
        $nsemester  = $requests->nsemester;
        $nket       = $requests->ket;

        $kelas    = $requests->idkelas;
        $semester   = $requests->sem;
        $matkul     = $requests->matkul;

        foreach ($nim as $key => $vnim) {
            $datanim [] = $vnim;
        }

        foreach ($absensi as $key => $vabsensi) {
            $dataabsensi [] = $vabsensi;
        }

        foreach ($seminar as $key => $vseminar) {
            $dataseminar [] = $vseminar;
        }

        foreach ($tugas as $key => $vtugas) {
            $datatugas [] = $vtugas;
        }

        foreach ($midsm as $key => $vmidsm) {
            $datamidsem [] = $vmidsm;
        }

        foreach ($nsemester as $key => $vnsemester) {
            $datansemester [] = $vnsemester;
        }

        foreach ($nket as $key => $vket) {
            $dataket [] = $vket;
        }


       for($i=0; $i<count($datanim); $i++){
            $data [] = array(

                            'nim'       => $datanim[$i],
                            'kodemk'    => $matkul,
                            'absensi'   => $dataabsensi[$i],
                            'seminar'   => $dataseminar[$i],
                            'tugas'     => $datatugas[$i],
                            'midsm'     => $datamidsem[$i],
                            'nsem'      => $datansemester[$i],
                            'keterangan' => $dataket[$i],
                            'iddosen'   => $dosen,
                            'idkelas'   => $kelas,
                            'semester'  => $semester
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
