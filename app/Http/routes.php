<?php
use Illuminate\Support\Facades\Input;
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
	return view('index');
});


Route::get('/login/userdosen',function(){
	/*$credentials=[
		'nidn'=>'',
		'password'=>''
	];*/
	return "belom ada!";
});

//logout mahasiswa




Route::group(['middleware' => 'web'],function(){
	
	Route::auth();
	Route::get('/home', 'HomeController@index');
	
	Route::get('login-mahasiswa','AuthMahasiswa\AuthController@showLoginForm');
	Route::post('login-mahasiswa',['as'=>'login-mahasiswa','uses'=>'AuthMahasiswa\AuthController@mahasiswaLoginPost']);
	Route::get('/logout-mahasiswa','AuthMahasiswa\AuthController@logoutmahasiswa');
	
	//error
	Route::get('/503',function(){
		abort(503);
	});
	
	
	//menu mahasiswa
	Route::get('menu_mahasiswa','Menu_MahasiswaController@index');

	// KRS
	Route::get('/home/addkrs','DaftarKrsController@index');
	Route::get('/home/listkrs','DaftarKrsController@listkrs');
	Route::get('/home/listkrs/{sem}','DaftarKrsController@showkrs');
	Route::get('/home/printkrs/{sem}','DaftarKrsController@printkrs');
	Route::get('/home/datamk/{sem}','DaftarKrsController@datamk');
	Route::get('/home/storekrs','DaftarKrsController@store');
});


	


Route::group(['middleware'=>'auth'],function(){
	
	//matakuliah
	Route::get('/home/showmatakuliah','MataKuliahController@index');
	Route::get('/home/addmatakuliah','MataKuliahController@add');
	//simpan matakuliah
	Route::post('/home/storematakuliah','MataKuliahController@store');
	//autocomplete cek kode mata kuliah
	Route::post('/home/kodemk_autocomplete','MataKuliahController@autocomplete');
	//getdatatable matakuliah
	Route::controller('/home/datatablesmatakuliah', 'MataKuliahController', [
		'getData'  => 'datatablesmatakuliah.data',
		'getIndex' => 'datatablesmatakuliah',
	]);
	//Route::get('/home/datamatakuliah','MataKuliahController@show');
	//hapus matakuliah
	Route::post('/home/deletematakuliah','MataKuliahController@destroy');
	//edit matakuliah
	Route::get('/home/edit_matakuliah/{kodemk}','MataKuliahController@edit');
	//update matakuliah
	Route::post('/home/updatematakuliah','MataKuliahController@updatematakuliah');

	//mahasiswa
	Route::get('/home/showmahasiswa','MahasiswaController@index');
	Route::get('/home/deletemahasiswa/{nim}','MahasiswaController@destroy');
	Route::get('/home/detailmahasiswa/{nim}','MahasiswaController@detail');
	
	
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
	
	//dosen
	Route::get('/home/showdosen','DosenController@index');
	Route::get('/home/editdosen/{id}','DosenController@edit');
	Route::get('/home/adddosen','DosenController@add');
	Route::post('/home/adddosen','DosenController@store');

	//kelas
	Route::get('/home/showkelas','KelasController@index');
	Route::get('/home/edit_kelas/{id}','KelasController@edit');
	Route::post('/home/editkelas','KelasController@update');
	Route::get('/home/addkelas','KelasController@add');
	Route::post('/home/storekelas','KelasController@store');
	Route::post('/home/kode_kelas_autocomplete','KelasController@autocomplete');
	Route::controller('/home/datatableskelas', 'KelasController', [
		'getData'  => 'datatableskelas.data',
		'getIndex' => 'datatableskelas',
	]);
	Route::post('/home/deletekelas','KelasController@destroy');
	//kelas mahasiswa
	Route::get('/home/showkelasmahasiswa','KelasMahasiswaController@index');
	Route::get('/home/addkelasmahasiswa','KelasMahasiswaController@add');
	Route::post('/home/storekelasmahasiswa','KelasMahasiswaController@store');
	Route::get('/home/editkelasmahasiswa','KelasMahasiswaController@edit');
	Route::post('/home/updatekelasmahasiswa','KelasMahasiswaController@update');
	Route::post('/home/deletekelasmahasiswa','KelasMahasiswaController@destroy');
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

Route::group(['middleware' => ['usermahasiswas']],function(){
	Route::get('/home/menu_mahasiswa/{nim}','UserMahasiswaController@index');
	Route::get('/home/menu_mahasiswa/changepassword/{nim}',
	['uses'=>'UserMahasiswaController@changepassword',
	'as'=>'mahasiswa-changepassword']);
	Route::post('/home/mahasiswa/changepasswords','UserMahasiswaController@postchangepassword');
	
	Route::post('/home/mahasiswa/TempUpload','UserMahasiswaController@TempUpload');
});
