<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\UserMahasiswa;
use DB;
use Yajra\Datatables\Datatables;
class UserController extends Controller
{
    //
	public function add_user_mahasiswa(){
		return view('user_mahasiswa.register');
	}
	
	public function store_user_mahasiswa(Request $request){
		
			$model = new UserMahasiswa;
			$model->nim = $request->nim;
			$model->nama = $request->nama;
			$model->email = $request->email;
			$model->password = bcrypt($request->password);
			$model->remember_token = $request->_token;
			$model->save();
			$stat=1;
			
		
		return response()->json(['return' => $stat]);
	}
	
	
	//autocomplete mahasiswa
	public function autocomplete_mahasiswa_checknim(Request $request){
		$stat=0;
		$term = $request->get('term');
		$results = array();
		$queries = DB::table('mahasiswa')->where('nim', 'LIKE', '%'.$term.'%')->take(5)->get();
	
			foreach ($queries as $query){
				$results[] = ['nim' => $query->nim, 'nama' => $query->nama];
			}
		
		return response()->json($results);
		
	
		
		//return Response::json($results);
		/*if (UserMahasiswa::where('nim', '=',$term)->exists()) {
			$statreturn=1;
			return response()->json($statreturn);
		}*/
	}
	
	/**
	 * Displays datatables front end view
	 *
	 * @return \Illuminate\View\View
	 */
	public function getIndex_usermahasiswa()
	{
		return view('datatables_usermahasiswa.index');
	}
	
	/**
	 * Process datatables ajax request.
	 *
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function getData_usermahasiswa()
	{
		return Datatables::of(UserMahasiswa::query())->make(true);
	}
	
	public function add_user_dosen(){
		return view('user_dosen.register');
	}
	
	
	public function store_user_dosen(Request $request){
			$model_dosen = new ModelUsersDosen;
			$model_dosen->nidn = $request->nidn;
			$model_dosen->nama = $request->nama;
			$model_dosen->email = $request->email;
			$model_dosen->password = bcrypt($request->password);
			
			$model_dosen->save();
			$stat=1;
			return response()->json(['return' => $stat]);
	}
	
}
