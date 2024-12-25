<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\user_types;
class UserTypeController extends Controller
{
    function createUserType(Request $req){
        $user_id=$req->user_id;
        $user_type=$req->user_type;
        user_types::insert([
            "user_id"=>$user_id,
            "user_type"=>$user_type
        ]);
        return response()->json([
            "status"=>"success",
            "data"=>user_types::where('user_type',$user_type)->get()
        ]);
    }
    function checkUserType(Request $req){
        $user_id=$req->user_id;
       
        $user_type=user_types::where("user_id",$user_id)->first();
        if(!empty($user_type)){
        return response()->json([
            "status"=>"success",
            "type"=>$user_type["user_type"]
        ]);}
        else{
            return response()->json(["failed","user not found"],404);
        }
    }
}
