<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UserTypeController;
use App\Http\Controllers\SmartPlotsController;
use App\Http\Controllers\TasksController;
use App\Http\Controllers\HelloController;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/
Route::get('/Hello',[HelloController::class,'HelloController']);
Route::post('/finishTask',[TasksController::class,'finishTask']);
Route::post('/deleteTask',[TasksController::class,'removeTask']);
Route::post('/getTasks',[TasksController::class,'getTasks']);
Route::post('/createTask',[TasksController::class,'createTask'])->middleware('createTasks');
Route::post('/createPlot',[SmartPlotsController::class,'CreatePlot']);
Route::post('/getPlots',[SmartPlotsController::class,'getPlots']);
Route::post('/insertUser',[UserTypeController::class,'createUserType']);
//->middleware('userType');
Route::post('/getHistory',[TasksController::class,'getHistory']);
Route::post('/schedule',[TasksController::class,'getCurrentTask']);
Route::controller(UserController::class)->group(function () {
    Route::post('login', 'login');
    Route::post('register', 'register');
    Route::post('logout', 'logout');
    Route::post('refresh', 'refresh');

});

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
