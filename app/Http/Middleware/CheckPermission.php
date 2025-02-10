<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Log;

class CheckPermission
{
    public function handle(Request $request, Closure $next): Response
    {
        $user = auth('admin')->user();
        if (!$user) {
            return response()->json(['message' => '未登录'], 401);
        }
        Log::info('当前用户id：' . $user->id);
        Log::info('当前用户：' . $user->username);
        Log::info('当前用户角色：' . $user->roles);

        // 构造当前请求的权限标识
        $method = strtolower($request->method());
        $path = $request->path();
        // 去掉 api 前缀
        $path = str_replace('api/', '', $path);

        //数字换成*
        $path_arr = explode('/',$path);
		array_walk($path_arr,function (&$item){
			if(is_numeric($item)){
				$item = '*';
			}
		});
		$path = implode('/',$path_arr);

        $action = $method . '@' . $path;

        Log::info('当前请求的权限标识：' . $action);

        // 获取用户所有角色的所有权限
        $hasPermission = $user->roles()
            ->with('permissions')
            ->get()
            ->flatMap(function ($role) {
                return $role->permissions;
            })
            ->pluck('action')
            ->contains($action);

        if (!$hasPermission) {
            return response()->json(['message' => '没有权限'], 403);
        }

        return $next($request);
    }
} 