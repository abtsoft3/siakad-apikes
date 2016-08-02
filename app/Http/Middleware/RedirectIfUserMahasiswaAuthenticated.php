<?php

namespace App\Http\Middleware;

use Closure;

class RedirectIfUserMahasiswaAuthenticated
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next,$guard = 'isMahasiswa')
    {
         if (!Auth::guest() && Auth::guard($guard)->check()) {
             return $next($request);
           
        }
         return redirect('/menu_mahasiswa/index');
    }
}
