<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\sales;
use App\Models\UserPlots;
use GuzzleHttp\Promise\Create;

class SalesController extends Controller
{
    function Sale(Request $req){
        $cost=$req->cost;
        $product=$req->product;
        $plot_id=$req->plot_id;
        $supplier_id=$req->supplier_id;
        $product_serial=$req->product_serial;
        if(!$plot_id||!$product||!$product||!$cost||!$supplier_id){
            return response()->json(["message"=>"sale failed"]);

        }
        sales::create([
            "cost"=>$cost,
            "product"=>$product,
            "supplier_id"=>$supplier_id,
            "plot_id"=>$plot_id,
            "product_serial"=>$product_serial
        ]);
        $plot=UserPlots::where("id",$plot_id)->first();
        $plot->delete();
        return response()->json(["message"=>"success"]);

    }
}
