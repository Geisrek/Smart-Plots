<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\user_types;
class UserTypeController extends Controller
{
    function createUserType(Request $req){
        $user_id=$req->query('user_id');
        $user_type=$req->query('user_type');
        user_types::insert([
            "user_id"=>$user_id,
            "user_type"=>$user_type
        ]);
        return response()->json([
            "status"=>"success",
            "data"=>user_types::where('user_type',$user_type)->get()
        ]);
    }
}
