<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use App\ModelDosen;
use App\UserDosen;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Hash;

class UserDosenController extends Controller
{
    //
    protected $guard ='userdosens';
	public function __construct()
    {
        $this->middleware($this->guard, ['except' => 'logoutdosen']);
    }
	public function index($nim)
	{
			if(isset($nidn)){
				$model = ModelDosen::findOrfail($nidn);
				return view('menu_mahasiswa.index')->with('model',$model);
		}
	}
	
	public function changepassword($nim){
		if(isset($nim)){
			return view('menu_mahasiswa.changepassword');
		}
	}
	
	public function postchangepassword(Request $request)
	{
		$models = UserMahasiswa::where('nim',$request->nim)->first();
		
		if (Hash::check($request->LastPassword, $models->password))
		{
			$models->password = bcrypt($request->NewPassword);
			$models->save();
			return redirect('/home/menu_mahasiswa'.'/'.$request->nim);
		}else{
			return Redirect::back()->with('AuthErr','Password lama tidak cocok')->withInput($request->except('password'));
		}
	}
	
	public function TempUpload(Request $request)
	{
		$models = UserMahasiswa::where('nim',$request->nim)->first();
		$imgpath = $request->file('image_user');
		$img_data = file_get_contents($imgpath);
		$base64 = base64_encode($img_data);

		$models->image_user = $base64;
		$execute = $models->save();
		if($execute){
			return Redirect::back();
		}
		
	}
}
