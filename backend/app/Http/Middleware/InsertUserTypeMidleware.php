<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use App\Models\user_types;
class InsertUserTypeMidleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $user_type=user_types::where('user_type',$request['user_type'])->get();
        if(count(get_object_vars($user))>=1){
            return response()->json([
                "success"=>"fail",
                "message"=>"this user already have a type"
            ]);
        }
        return $next($request);
    }
}
