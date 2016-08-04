<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/
Route::get('/',function(){
	return view('welcome');
});


Route::get('/login/userdosen',function(){
	/*$credentials=[
		'nidn'=>'',
		'password'=>''
	];*/
	return "belom ada!";
});


Route::group(['middleware' => 'web'],function(){
	
	Route::auth();
	Route::get('/home', 'HomeController@index');
	Route::get('login-mahasiswa','AuthMahasiswa\AuthController@showLoginForm');
	Route::post('login-mahasiswa',['as'=>'login-mahasiswa','uses'=>'AuthMahasiswa\AuthController@mahasiswaLoginPost']);
	//error
	Route::get('503',function(){
		abort(503);
	});

	//menu mahasiswa
	//Route::get('menu_mahasiswa','Menu_MahasiswaController@index');
});

Route::group(['middleware'=>'auth'],function(){
	//menu mahasiswa
	Route::get('/menu_mahasiswa','UserMahasiswaController@index');
	
	//matakuliah
	Route::get('/home/showmatakuliah','MataKuliahController@index');
	Route::get('/home/addmatakuliah','MataKuliahController@add');
	//simpan matakuliah
	Route::post('/home/storematakuliah','MataKuliahController@store');
	//autocomplete cek kode mata kuliah
	Route::post('/home/kodemk_autocomplete','MataKuliahController@autocomplete');
	//getdatatable matakuliah
	Route::controller('/home/datatables', 'MataKuliahController', [
		'getData'  => 'datatables.data',
		'getIndex' => 'datatables',
	]);
	//hapus matakuliah
	Route::post('/home/deletematakuliah','MataKuliahController@destroy');
	//edit matakuliah
	Route::get('/home/edit_matakuliah/{kodemk}','MataKuliahController@edit');
	//update matakuliah
	Route::post('/home/updatematakuliah','MataKuliahController@updatematakuliah');

	//mahasiswa
	Route::get('/home/showmahasiswa','MahasiswaController@index');
	Route::get('/home/deletemahasiswa/{nim}','MahasiswaController@destroy');
	
	
	Route::post('/home/nim_autocomplete','MahasiswaController@autocomplete');
	Route::get('/home/addmahasiswa','MahasiswaController@add');
	Route::post('/home/addmahasiswa','MahasiswaController@store');
	

	Route::get('/home/editmahasiswa/{nim}','MahasiswaController@edit');
	Route::post('/home/editmahasiswa/{nim}','MahasiswaController@update');

	Route::get('/home/datamahasiswa','MahasiswaController@show');

	//periode
	Route::get('/home/showperiode','PeriodeController@index');
	Route::get('/home/addperiode','PeriodeController@add');
	//simpan periode
	Route::post('/home/storeperiode','PeriodeController@store');
	//show periode
	Route::controller('/home/datatablesperiode', 'PeriodeController', [
		'getData'  => 'datatablesperiode.data',
		'getIndex' => 'datatablesperiode',
	]);
	//hapus periode
	Route::post('/home/deleteperiode','PeriodeController@destroy');
	//edit periode
	Route::get('/home/edit_periode/{idperiode}','PeriodeController@edit');
	//update periode
	Route::post('/home/updateperiode','PeriodeController@updateperiode');

	
	// KRS
	Route::get('/home/addkrs','DaftarKrsController@index');
	Route::get('/home/listkrs','DaftarKrsController@listkrs');
	Route::get('/home/listkrs/{sem}','DaftarKrsController@showkrs');
	Route::get('/home/printkrs/{sem}','DaftarKrsController@printkrs');
	Route::get('/home/datamk/{sem}','DaftarKrsController@datamk');
	Route::get('/home/storekrs','DaftarKrsController@store');
});

Route::group(['middleware' => ['auth', 'isAdmin']], function () {
   //here 
   //mahasiswa user register
	Route::get('/home/register_mahasiswa', 'UserController@add_user_mahasiswa');
	Route::post('/home/store_register_mahasiswa', 'UserController@store_user_mahasiswa');
	Route::post('/home/mahasiswa_user_autocomplete','UserController@autocomplete_mahasiswa_checknim');
	Route::controller('/home/datatables_usermahasiswa', 'UserController', [
		'getData_usermahasiswa'  => 'datatables_usermahasiswa.data',
		'getIndex_usermahasiswa' => 'datatables_usermahasiswa',
	]);
	Route::get('/home/show_users_mahasiswa',function(){
		return view('user_mahasiswa.show_users_mahasiswa');
	});
	//dosen user register
	Route::get('/home/register_dosen', 'UserController@add_user_dosen');
	Route::post('/home/store_register_user_dosen', 'UserController@store_user_dosen');
});


