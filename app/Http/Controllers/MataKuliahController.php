<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\MataKuliahModel;
use Yajra\Datatables\Datatables;
use NotFoundHttpException;
class MataKuliahController extends Controller
{
	
    //
	public function index(){
		return view('matakuliah.show_matakuliah');
	}
	
	public function edit($kodemk){
		 
				$arrsemester =array(
					'1'=>'Semester 1',
					'2'=>'Semester 2',
					'3'=>'Semester 3',
					'4'=>'Semester 4',
					'5'=>'Semester 5',
					'6'=>'Semester 6',
					'7'=>'Semester 7',
					'8'=>'Semester 8');
				
			$matakuliah = MataKuliahModel::findOrfail($kodemk);
			return view('matakuliah.edit_matakuliah',array('arrsemester' => $arrsemester))->with('matakuliah',$matakuliah);
			
	}
	
	public function autocomplete(Request $request){
		$statreturn = 0;
		$term = $request->get('term');
		if (MataKuliahModel::where('kodemk', '=',$term)->exists()) {
			$statreturn=1;
		}
		return response()->json(['return' => $statreturn]);
	}
	
	public function add(){
		$arrsemester =array(
		'1'=>'Semester 1',
		'2'=>'Semester 2',
		'3'=>'Semester 3',
		'4'=>'Semester 4',
		'5'=>'Semester 5',
		'6'=>'Semester 6',
		'7'=>'Semester 7',
		'8'=>'Semester 8');
		return view('matakuliah.add_matakuliah',array('arrsemester' => $arrsemester));
	}
	
	public function store(Request $request){
		$stat=0;
		$tbmatakuliah = new MataKuliahModel;
		$validator = $tbmatakuliah->validate($request->all());
			
		if($validator->passes()){
			$tbmatakuliah = new MataKuliahModel;
			$tbmatakuliah->kodemk = $request->kodemk;
			$tbmatakuliah->matakuliah = $request->matakuliah;
			$tbmatakuliah->bobot = $request->bobot;
			$tbmatakuliah->teori = $request->teori;
			$tbmatakuliah->praktek = $request->praktek;
			$tbmatakuliah->kadep = $request->kadep;
			$tbmatakuliah->semester = $request->semester;
			$tbmatakuliah->bobotnilai = $request->bobotnilai;
			$tbmatakuliah->save();
			$stat=1;
			
		}else{
			$stat=2;
		}
		
		return response()->json(['return' => $stat]);
	}
	
	public function updatematakuliah(Request $request){
			$stat=0;
			//validasi
			$tbmatakuliah = new MataKuliahModel;
			$validator = $tbmatakuliah->validate($request->all());
			//
			if($validator->passes()){
				$kodemk=$request->kodemk;
				$edit_mk=MataKuliahModel::find($kodemk);
					if($edit_mk){
						$edit_mk->matakuliah = $request->matakuliah;
						$edit_mk->bobot = $request->bobot;
						$edit_mk->teori = $request->teori;
						$edit_mk->praktek = $request->praktek;
						$edit_mk->kadep = $request->kadep;
						$edit_mk->semester = $request->semester;
						$edit_mk->bobotnilai = $request->bobotnilai;
						$edit_mk->save();
						$stat=1;
				}
			}
		
		return response()->json(['return' => $stat]);
	}
	
	public function destroy(Request $request){
		$statreturn = 0;
		$term = $request->get('kodemk');
		if(MataKuliahModel::destroy($term)){
			$statreturn=1;
		}
		return response()->json(['return' => $statreturn]);
	}
	
	
	
	/**
	 * Displays datatables front end view
	 *
	 * @return \Illuminate\View\View
	 */
	public function getIndex()
	{
		return view('datatablesmatakuliah.index');
	}
	public function getData()
	{
		return Datatables::of(MataKuliahModel::query())->make(true);
	}
	
	/**
	 * Process datatables ajax request.
	 *
	 * @return \Illuminate\Http\JsonResponse
	 */
	

	/*public function show(){

		$model = new MataKuliahModel;
		$data = $model->show();

		return Datatables::of($data)->make(true);
	}*/
}
