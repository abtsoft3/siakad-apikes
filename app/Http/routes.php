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


//matakuliah
Route::get('showmatakuliah','MataKuliahController@index');
Route::get('addmatakuliah','MataKuliahController@add');