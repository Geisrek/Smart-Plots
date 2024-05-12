<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\user_plots;
class SmartPlotsController extends Controller
{
    function CreatePlot(Request $req){
       $user_id=$req->user_id;
       $address=$req->address;
       $product=$req->product;
       user_plots::create([
        'user_id'=>$user_id,
        'address'=>$address,
        'product'=>$product
       ]);
       return response()->json([
        "status"=>"success"
       ]);
    }
    function getPlots(Request $req){
        $user_id=$req->user_id;
        $plots=user_plots::where('user_id')->get();
        

    }
}
