<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class CheckPermission
{
    public function handle(Request $request, Closure $next): Response
    {
        $user = auth('admin')->user();
        if (!$user) {
            return response()->json(['message' => '未登录'], 401);
        }

        // 构造当前请求的权限标识
        $method = strtolower($request->method());
        $path = $request->path();
        $action = $method . '@' . $path;

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