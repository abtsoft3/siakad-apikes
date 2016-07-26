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
Route::get('addmahasiswa','MahasiswaController@add');

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

//error
Route::get('503',function(){
	abort(503);
});