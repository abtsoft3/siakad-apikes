<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\PeriodeModel;
use Yajra\Datatables\Datatables;
use NotFoundHttpException;
use App\Http\Controllers\Controller;

class PeriodeController extends Controller
{
    //
	public function index(){
		return view('periode.show_periode');
	}
	
	public function add(){
		
		return view('periode.add_periode');
	}
	
	public function store(Request $request){
		$stat=0;
		$model = new PeriodeModel;
		//$validator = $tbmatakuliah->validate($request->all());
			
		//if($validator->passes()){
			//$tbmatakuliah = new MataKuliahModel;
			$model->tglawal = $request->tglawal;
			$model->tglakhir = $request->tglakhir;
			$model->sistem = $request->sistem;
			$model->save();
			$stat=1;
			
		//}else{
			//$stat=2;
		//}
		
		return response()->json(['return' => $stat]);
	}
	
	/**
	 * Displays datatables front end view
	 *
	 * @return \Illuminate\View\View
	 */
	public function getIndex()
	{
		return view('datatablesperiode.index');
	}
	
	/**
	 * Process datatables ajax request.
	 *
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function getData()
	{
		return Datatables::of(PeriodeModel::query())->make(true);
	}
}
