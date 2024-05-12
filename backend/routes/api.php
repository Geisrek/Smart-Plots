<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UserTypeController;
use App\Http\Controllers\SmartPlotsController;
use App\Http\Controllers\TasksController;


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
Route::post('/deleteTask',[TasksController::class,'removeTask']);
Route::post('/createTask',[TasksController::class,'createTask']);
Route::post('/createPlot',[SmartPlotsController::class,'CreatePlot']);
Route::post('/insertUser',[UserTypeController::class,'createUserType'])->middleware('userType');
Route::controller(UserController::class)->group(function () {
    Route::post('login', 'login');
    Route::post('register', 'register');
    Route::post('logout', 'logout');
    Route::post('refresh', 'refresh');

});

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
