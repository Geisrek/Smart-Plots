<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\sales;
use App\Models\UserPlots;
use App\Models\user_types;
use Illuminate\Support\Facades\DB;
use App\Models\User;
class SalesController extends Controller
{
    function Sale(Request $req){
       
        $cost=$req->cost;
        $product=$req->product;
        $plot_id=$req->plot_id;
        $supplier_id=$req->supplier_id;
        $product_serial=$req->product_serial;
        $currency_unit=$req->currency_unit;
        if(!$plot_id||!$product||!$product||!$cost||!$supplier_id||!$currency_unit){
            return response()->json(["message"=>"sale failed","request"=> $req->all()]);

        }
        sales::create([
            "cost"=>$cost,
            "product"=>$product,
            "supplier_id"=>$supplier_id,
            "plot_id"=>$plot_id,
            "product_serial"=>$product_serial,
            "currency_unit"=>$currency_unit
        ]);
        $plot=UserPlots::where("id",$plot_id)->first();
        $plot->delete();
        return response()->json(["message"=>"success"]);

    }
    public function getUser(Request $request){
        $id=$request->id;
        $user=User::find($id);
        return response()->json($user);
    }
    function getProducts(Request $req){
        $user_id=$req->user_id;
        if(!$user_id){
            return response()->json(["message"=>"No user type"],500);
        }
        $user_type=user_types::where("user_id",$user_id)->first();
        if(! empty($user_type)){
            if($user_type["user_type"]=="vendor"){
                $products=DB::table('sales')->join('user_types','sales.supplier_id',"=","user_types.user_id")->select('sales_id','product','supplier_id','cost','product_serial','currency_unit','plot_id')->where('user_types.user_type',"farmer")->get();
                foreach ($products as $product) { 
                    $user_id = $product->supplier_id;
                     $user = User::where('id', $user_id)->first(); 
                     $product->supplier_name = $user->name; }
                return response()->json($products);
        }
        
        else if($user_type["user_type"]=="client"){
            $products=DB::table('sales')->join('user_types','sales.supplier_id',"=","user_types.user_id")->select('sales_id','product','supplier_id','cost','product_serial','currency_unit','plot_id')->where('user_types.user_type',"vendor")->get();
            foreach ($products as $product) { 
                $user_id = $product->supplier_id; 
                $user = User::where('id', $user_id)->first(); 
                $product->supplier_name = $user->name; }
            return response()->json($products);
            }
        else{
            return response()->json(["message"=>"You are not registered yet or no product for your type"]);
        }
    
    }
    }
}
