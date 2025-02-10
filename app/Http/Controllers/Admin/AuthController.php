<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\AdminUser;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    /**
     * 管理员登录
     *
     * @param Request $request
     * @return JsonResponse
     * @throws ValidationException
     */
    public function login(Request $request): JsonResponse
    {
        $this->validate($request, [
            'username' => 'required|string',
            'password' => 'required|string',
        ]);

        $credentials = $request->only('username', 'password');

        if (!$token = Auth::guard('admin')->attempt($credentials)) {
            return response()->json([
                'code' => 1,
                'message' => '用户名或密码错误'
            ], 401);
        }

        return $this->respondWithToken($token);
    }

    /**
     * 获取当前登录用户信息
     *
     * @return JsonResponse
     */
    public function me(): JsonResponse
    {
        return response()->json([
            'code' => 0,
            'data' => Auth::guard('admin')->user()
        ]);
    }

    /**
     * 退出登录
     *
     * @return JsonResponse
     */
    public function logout(): JsonResponse
    {
        Auth::guard('admin')->logout();

        return response()->json([
            'code' => 0,
            'message' => '已成功退出登录'
        ]);
    }

    /**
     * 刷新 token
     *
     * @return JsonResponse
     */
    public function refresh(): JsonResponse
    {
        return $this->respondWithToken(Auth::guard('admin')->refresh());
    }

    /**
     * 格式化返回 token 数据
     *
     * @param string $token
     * @return JsonResponse
     */
    protected function respondWithToken(string $token): JsonResponse
    {
        return response()->json([
            'code' => 0,
            'data' => [
                'access_token' => $token,
                'token_type' => 'bearer',
                'expires_in' => Auth::guard('admin')->factory()->getTTL() * 60
            ]
        ]);
    }
} 