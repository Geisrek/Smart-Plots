<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\tasks;

class TasksController extends Controller
{
    function createTask(Request $req){
        tasks::craete([
            'light'=>$req->light,
            'sol_humidity'=>$req->sol_humidity,
            'air_humidity',
            'temperature',
            'schedule_date',
            'plot_id'
        ]);
    }
}
