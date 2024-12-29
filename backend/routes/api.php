<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UserTypeController;
use App\Http\Controllers\SmartPlotsController;
use App\Http\Controllers\TasksController;
use App\Http\Controllers\HelloController;
use App\Http\Controllers\SalesController;
use App\Http\Controllers\SalesdetailesController;

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
Route::post('/get_tasks',[SmartPlotsController::class,'getTasks']);
Route::post('/getPlots',[SmartPlotsController::class,'getPlots']);
Route::post('/insertUser',[UserTypeController::class,'createUserType']);
Route::post('/checkUser',[UserTypeController::class,'checkUserType']);
Route::post('/getUserPlots',[UserController::class,'getUserPlots']);
Route::post('/getUser',[SalesController::class,'getUser']);
Route::post('/getHistory',[TasksController::class,'getHistory']);
Route::post('/schedule',[TasksController::class,'getCurrentTask']);
Route::post('/Sale',[SalesController::class,'Sale']);
Route::post('/getHistorySaleBySerial',[SalesController::class,'getHistoryBySerial']);
Route::post('/getSaleBySerial',[SalesController::class,'getSaleBySerial']);
Route::post('/updateCost',[SalesController::class,'updateCost']);
Route::post('/getProducts',[SalesController::class,'getProducts']);
Route::post('/getHistoryBySerial',[SalesdetailesController::class,'getHistoryBySerial']);
Route::post('/addToCard',[SalesdetailesController::class,'addToCard']);
Route::post('/geteDeals',[SalesdetailesController::class,'geteDeals']);
Route::post('/makeDeal',[SalesdetailesController::class,'makeDeal']);
Route::post('/getUserSale',[SalesdetailesController::class,'getUserSale']);
Route::post('/removeSale',[SalesdetailesController::class,'removeSale']);
Route::controller(UserController::class)->group(function () {
    Route::post('login', 'login');
    Route::post('register', 'register');
    Route::post('logout', 'logout');
    Route::post('refresh', 'refresh');

});

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
