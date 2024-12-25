<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\salesdetails;
use App\Models\history;
use App\Models\sales;
use App\Models\user_types;
use Illuminate\Support\Facades\DB;
use function PHPUnit\Framework\isEmpty;

class SalesdetailesController extends Controller
{
    function getHistoryBySerial(Request $req){
        $serial=$req->serial;
        if(!$serial){
            return response()->json([
                "message"=>"failed no serial received"
            ],500);
        }
        $sale=salesdetails::where("product_serial",$serial)->first();
        if(!$sale){
            return response()->json([
                "message"=>"failed the serial is not exist"
            ],500);
        }
        $history=history::where("plot_id",$sale["product_id"])->get();
        return response()->json($history);
    }
    function addToCard(Request $req){
        $client_id=$req->client_id;
        $product_id=$req->product_id;
        $opened=0;
        if(!$product_id||!$client_id){
            return response()->json([
                "message"=>"failed "
            ],500);
        }
        $sale=sales::where("plot_id",$product_id)->first();
        if(!$sale){
            return response()->json([
                "message"=>"failed the plot is not exist"
            ],500);
        }
        salesdetails::create([
            "product_id"=>$product_id,
            "product_serial"=>$sale["product_serial"],
            "opened"=>$opened,
            "client_id"=>$client_id
        ]);
        return response()->json(["message"=>"success"]);
    }
    function geteDeals(Request $req){
        $client_id=$req->client_id;
        $deale_id=$req->deal_id;
       $card= DB::table("salesdetails")->join("sales","salesdetails.product_id","=","sales.plot_id")->select('id','sales_id','product','supplier_id','product_id','sales.product_serial','cost','currency_unit')->where('client_id',$client_id)->where("opened",0)->get();
       return response()->json($card);
       
    }
    function makeDeal(Request $req){
        $saledetail_id=$req->saledetail_id;
        $cost=$req->cost;
        $sale_detale=salesdetails::find($saledetail_id);
        $sale_detale->update([
            "opened"=>1
        ]);
        $client_id=$sale_detale["client_id"];
        $product_id=$sale_detale["product_id"];
        
        $sale=sales::where("plot_id",$product_id)->first();
        
        $product_serial=$sale["product_serial"];
        $currency_unit=$sale["currency_unit"];
        $product=$sale["product"];
       sales::create([
            "cost"=>$cost,
            "supplier_id"=>$client_id,
            "plot_id"=>$product_id,
            "product_serial"=>$product_serial,
            "currency_unit"=>$currency_unit,
            "product"=>$product
    ]);
    $sale->delete();
   
        return response()->json([
           "message"=>"success"
        ]);

        
    }
}
