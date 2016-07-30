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


Route::group(['middleware' => 'web'],function(){
	Route::auth();
	//Route::get('/', function () {return view('layouts.app');});
	
	
	
	
	
	//matakuliah
	Route::get('showmatakuliah','MataKuliahController@index');
	Route::get('addmatakuliah','MataKuliahController@add');
	//simpan matakuliah
	Route::post('/storematakuliah','MataKuliahController@store');
	//autocomplete cek kode mata kuliah
	Route::post('kodemk_autocomplete','MataKuliahController@autocomplete');
	//getdatatable matakuliah
	Route::controller('datatables', 'MataKuliahController', [
		'getData'  => 'datatables.data',
		'getIndex' => 'datatables',
	]);
	//hapus matakuliah
	Route::post('/deletematakuliah','MataKuliahController@destroy');
	//edit matakuliah
	Route::get('edit_matakuliah/{kodemk}','MataKuliahController@edit');
	//update matakuliah
	Route::post('/updatematakuliah','MataKuliahController@updatematakuliah');

	Route::get('/', 'HomeController@index');

	//mahasiswa
	Route::get('showmahasiswa','MahasiswaController@index');
	Route::get('deletemahasiswa/{nim}','MahasiswaController@destroy');

	Route::get('addmahasiswa','MahasiswaController@add');
	Route::post('addmahasiswa','MahasiswaController@store');

	Route::get('editmahasiswa/{nim}','MahasiswaController@edit');
	Route::post('editmahasiswa/{nim}','MahasiswaController@update');

	Route::get('datamahasiswa','MahasiswaController@show');

	//periode
	Route::get('showperiode','PeriodeController@index');
	Route::get('addperiode','PeriodeController@add');
	//simpan periode
	Route::post('/storeperiode','PeriodeController@store');
	//show periode
	Route::controller('datatablesperiode', 'PeriodeController', [
		'getData'  => 'datatablesperiode.data',
		'getIndex' => 'datatablesperiode',
	]);
	//hapus periode
	Route::post('/deleteperiode','PeriodeController@destroy');
	//edit periode
	Route::get('edit_periode/{idperiode}','PeriodeController@edit');
	//update periode
	Route::post('/updateperiode','PeriodeController@updateperiode');

	//daftar KRS
	Route::get('listkrs','DaftarKrsController@index');
	Route::get('listkrs/{sem}','DaftarKrsController@showkrs');
	Route::get('printkrs','DaftarKrsController@printkrs');


	//error
	Route::get('503',function(){
		abort(503);
	});

	//menu mahasiswa
	Route::get('menu_mahasiswa','Menu_MahasiswaController@index');
});
Route::group(['middleware' => ['auth', 'isAdmin']], function () {
   //here 
   //userregister
	Route::get('register', 'Auth\AuthController@getRegister');
	Route::post('register', 'Auth\AuthController@postRegister');
});
<<<<<<< HEAD
//mahasiswa
Route::get('showmahasiswa','MahasiswaController@index');
Route::get('deletemahasiswa/{nim}','MahasiswaController@destroy');

Route::get('addmahasiswa','MahasiswaController@add');
Route::post('addmahasiswa','MahasiswaController@store');

Route::get('editmahasiswa/{nim}','MahasiswaController@edit');
Route::post('editmahasiswa/{nim}','MahasiswaController@update');

Route::get('datamahasiswa','MahasiswaController@show');

//periode
Route::get('showperiode','PeriodeController@index');
Route::get('addperiode','PeriodeController@add');
//simpan periode
Route::post('/storeperiode','PeriodeController@store');
//show periode
Route::controller('datatablesperiode', 'PeriodeController', [
    'getData'  => 'datatablesperiode.data',
    'getIndex' => 'datatablesperiode',
]);
//hapus periode
Route::post('/deleteperiode','PeriodeController@destroy');
//edit periode
Route::get('edit_periode/{idperiode}','PeriodeController@edit');
//update periode
Route::post('/updateperiode','PeriodeController@updateperiode');



//matakuliah
Route::get('showmatakuliah','MataKuliahController@index');
Route::get('addmatakuliah','MataKuliahController@add');
//simpan matakuliah
Route::post('/storematakuliah','MataKuliahController@store');
//autocomplete cek kode mata kuliah
Route::post('kodemk_autocomplete','MataKuliahController@autocomplete');
//getdatatable matakuliah
Route::controller('datatables', 'MataKuliahController', [
    'getData'  => 'datatables.data',
    'getIndex' => 'datatables',
]);
//hapus matakuliah
Route::post('/deletematakuliah','MataKuliahController@destroy');
//edit matakuliah
Route::get('edit_matakuliah/{kodemk}','MataKuliahController@edit');
//update matakuliah
Route::post('/updatematakuliah','MataKuliahController@updatematakuliah');


// KRS
Route::get('listkrs','DaftarKrsController@listkrs');
Route::get('listkrs/{sem}','DaftarKrsController@showkrs');
Route::get('printkrs/{sem}','DaftarKrsController@printkrs');
Route::get('datamk/{sem}','DaftarKrsController@datamk');

Route::get('addkrs','DaftarKrsController@index');


//error
Route::get('503',function(){
	abort(503);
});
=======



>>>>>>> bbe948cc6a1308fe35c98aefd70baea5c620147a
