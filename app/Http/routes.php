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

Route::get('/', function () {
    return view('layouts.master');
});
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
    'getIndex' => 'datatables',
]);



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

//

//error
Route::get('503',function(){
	abort(503);
});