<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
class profileController extends Controller
{
    function getUserInfo(Request $req){
        $id=$req->id;
        return User::find($id);
    }
    public function uploadProfileImage(Request $req) { 
         $id=$req->id;
         $user=User::find($id);
        if ($req->hasFile('image')) { 
            $path = $req->file('image')->store('images', 'images');
           $user->update([
                "user_image"=>"images/".$path
            ]);
             return response()->json(['url' =>"images/".$path ]);
         } return response()->json(['error' => 'No file uploaded'], 400); 
        }
}
