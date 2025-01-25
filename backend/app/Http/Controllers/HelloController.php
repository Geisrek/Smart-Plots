<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
class HelloController extends Controller
{
    function HelloController(Request $req){
       return response()->json([
        "message"=>"Hello world"
       ]);
    }
    public function upload(Request $request) { 
        if ($request->hasFile('image')) { 
            $path = $request->file('image')->store('images', 'images');
             return response()->json(['url' =>"images/".$path ]);
         } return response()->json(['error' => 'No file uploaded'], 400); 
        }
        public function getImage(Request $req) {
            $path = $req->path; 
            if (Storage::disk('public')->exists($path)) { 
                $file =Storage::disk('public')->get($path); 
                $type = Storage::mimeType($path);
                if (!$type) { 
                 $type = mime_content_type(storage_path('app/public/' . $path)); 
                }
                 return response($file, 200)->header("Content-Type", $type);

                }
                 return response('File not found. '.$path.','.getcwd().',', 404);
                 }
        public function sensors(Request $req){
            return ["soil"=>rand(3000,4000),"temperature"=>rand(15,23),"humidity"=>'%'.rand(10,40),"lux"=>rand(40,50)];
        }
    
}
