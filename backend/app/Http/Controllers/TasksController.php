<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\tasks;
use App\Models\history;
use Carbon\Carbon;
class TasksController extends Controller
{
    function getTasks(Request $req){
        $plot_id=$req->plot_id;
        $tasks=tasks::where('plot_id',$plot_id)->get();
        return response()->json(["tasks"=>$tasks]);
    }
    
    function createTask(Request $req){
       
        tasks::create([
            'light'=>$req->light,
            'sol_humidity'=>$req->sol_humidity,
            'air_humidity'=>$req->air_humidity,
            'temperature'=>$req->temperature,
            'schedule_date'=>$req->schedule_date,
            'plot_id'=>$req->plot_id
        ]);
        return response()->json([
            "status"=>"success"
        ]);
    }
    function removeTask(Request $req){
        $id = $req->id;
        $task=tasks::where('id',$id)->first();
        $task->delete();
        return response()->json([
            "status"=>"element deleted success"
        ]);
    }
    function finishTask(Request $req){
        $id = $req->id;
        $task=tasks::where('id',$id)->first();
       
        history::create([
            'light'=> $task['light'],
            'air_humidity'=>$task['air_humidity'],
            'schedule_date'=>$task['schedule_date'],
            'sol_humidity'=>$task['sol_humidity'],
            'temperature'=> $task['temperature'],
            'plot_id'=> $task['plot_id']]);
       $task->delete();
        return response()->json([
            "status"=>"Task is finished",
           
        ]);
    }
    function getHistory(Request $req){
        $plot_id=$req->plot_id;
        $histories=history::where('plot_id',$plot_id)->get();
        return response()->json( $histories);
    }
    function getCurrentTask(Request $req){
        $plot_id=$req->plot_id;
        $currentTask=tasks::where('plot_id',$plot_id)->where('schedule_date',">=",Carbon::today())->get()->sortBy('schedule');
        
        return response()->json( $currentTask[0]);
    }
}
