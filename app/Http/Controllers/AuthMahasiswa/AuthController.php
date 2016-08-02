<?php

namespace App\Http\Controllers\AuthMahasiswa;

use App\UserMahasiswa;
use Validator;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\ThrottlesLogins;
use Illuminate\Foundation\Auth\AuthenticatesAndRegistersUsers;
use Illuminate\Http\Request;
class AuthController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Registration & Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles the registration of new users, as well as the
    | authentication of existing users. By default, this controller uses
    | a simple trait to add these behaviors. Why don't you explore it?
    |
    */

    use AuthenticatesAndRegistersUsers, ThrottlesLogins;

    /**
     * Where to redirect users after login / registration.
     *
     * @var string
     */
    protected $redirectTo = '/menu_mahasiswa/index';
//
   
    
  

    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array  $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validator(array $data)
    {
        return Validator::make($data, [
            'nama' => 'required|max:255',
            'nim' => 'required|max:255|unique:user_mahasiswas',
            'email' => 'required|email|max:255|unique:user_mahasiswas',
            'password' => 'required|min:6|confirmed',
        ]);
    }

    /**
     * Create a new user instance after a valid registration.
     *
     * @param  array  $data
     * @return User
     */
    protected function create(array $data)
    {
        return UserMahasiswa::create([
            'nama' => $data['nama'],
            'nim' => $data['nim'],
            'email' => $data['email'],
            'password' => bcrypt($data['password']),
        ]);
    }
	
	 public function showLoginForm()
	{
		return view('user_mahasiswa.login');
    }
	
	public function mahasiswaLoginPost(Request $request)
	{
		$this->validate($request,['nim' => 'required',
            'password' => 'required',]);
		
		if(auth()->guard('usermahasiswa')->attempt(['nim'=>$request->input('nim'),'password'=>$request->input('password')]))
		{
			$usermahasiswa = auth()->guard('usermahasiswa')->user();
			return redirect('/menu_mahasiswa/index');
		}else
		{
			return back()->with('error','your nim dan password salah.');
		}
	}

    public function logout(){
        Auth::guard('usermahasiswa')->logout();
         return view('user_mahasiswa.login');
    }
}
