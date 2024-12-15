<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Models\user_plots;
use Exception;

class SmartPlotsController extends Controller
{
    function CreatePlot(Request $req){
      try{
       $user_id=$req->user_id;
       $address=$req->address;
       $product=$req->product;
       $ip=$req->IP;
       
       user_plots::create([
        'user_id'=>$user_id,
        'address'=>$address,
        'product'=>$product,
        'IP'=>$ip
       ]);
       return response()->json([
        "status"=>"success"
       ]);}
       catch (Exception $e) {
        echo $e->getMessage();
         Log::error('Error creating plot:', ['message' => $e->getMessage(), 'trace' => $e->getTraceAsString()]);
          return response()->json(['error' => 'Internal Server Error'], 500);}
    }
    function getPlots(Request $req){
        $user_id=$req->user_id;
        $plots=user_plots::where('user_id',$user_id)->get();
        return response()->json([
            "message"=>"success",
            "plots"=>$plots
        ]);

    }
}
