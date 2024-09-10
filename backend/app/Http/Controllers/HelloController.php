<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class HelloController extends Controller
{
    function HelloController(Request $req){
       return response()->json([
        "message"=>"Hello world"
       ]);
    }
}
