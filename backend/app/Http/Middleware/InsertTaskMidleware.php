<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use App\Models\tasks;
class InsertTaskMidleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
       
        $isExist=tasks::where('schedule_date',$request['schedule_date'])->first();
       
        if(!is_null($isExist)&&count(get_object_vars($isExist))>=1){
            return response()->json([
                "success"=>"fail",
                "message"=>"this user already have a type"
            ]);
        }
        return $next($request);
    }
}
