<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\Admin\AuthController;
use App\Http\Controllers\Admin\MenuController;

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

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// 管理员认证相关路由
Route::prefix('admin')->group(function () {
    Route::post('login', [AuthController::class, 'login']);
    
    // 需要登录的路由
    Route::middleware('auth:admin')->group(function () {
        Route::post('logout', [AuthController::class, 'logout']);
        Route::post('refresh', [AuthController::class, 'refresh']);
        Route::get('me', [AuthController::class, 'me']);
    });
});

// 需要权限控制的路由
Route::middleware(['auth:admin', 'permission'])->group(function () {
    Route::get('/users', [UserController::class, 'index']);
    Route::post('/users', [UserController::class, 'store']);
    Route::delete('/users/{id}', [UserController::class, 'destroy']);

    Route::get('/goods', function () {
        return '商品列表';
    });

    Route::post('/goods', function () {
        return '创建商品';
    });

    Route::put('/goods/{id}', function ($id) {
        return '修改商品'.$id;
    });
});

// 在 auth:admin 中间件组内添加
Route::middleware(['auth:admin'])->group(function () {
    Route::get('/menus', [MenuController::class, 'getUserMenus']);
});