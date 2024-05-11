<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\tasks;

class TasksController extends Controller
{
    function createTask(Request $req){
        tasks::create([
            'light'=>$req->light,
            'sol_humidity'=>$req->sol_humidity,
            'air_humidity'=>$req->air_humidity,
            'temperature'=>$req->temperature,
            'schedule_date'=>$req->schedule_date,
            'plot_id'=>$req->plot_id
        ]);
    }
}
