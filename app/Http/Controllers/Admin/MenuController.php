<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\AdminMenu;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

class MenuController extends Controller
{
    /**
     * 获取当前用户的菜单列表
     */
    public function getUserMenus(): JsonResponse
    {
        // 获取当前用户
        $user = Auth::guard('admin')->user();
        
        // 获取用户的所有角色ID - 修改这里指定具体的表和字段
        $roleIds = $user->roles()
            ->select('admin_roles.id')  // 明确指定表名
            ->pluck('admin_roles.id');  // 明确指定表名
        
        // 获取这些角色可以访问的所有菜单
        $menus = AdminMenu::whereHas('roles', function ($query) use ($roleIds) {
                $query->whereIn('admin_roles.id', $roleIds);
            })
            ->where('status', 1)  // 只获取启用的菜单
            ->where('parent_id', 0)  // 先获取顶级菜单
            ->with(['children' => function ($query) use ($roleIds) {
                // 子菜单也需要检查权限
                $query->whereHas('roles', function ($q) use ($roleIds) {
                    $q->whereIn('admin_roles.id', $roleIds);
                })
                ->where('status', 1)
                ->orderBy('sort');
            }])
            ->orderBy('sort')
            ->get();

        return response()->json([
            'code' => 0,
            'message' => 'success',
            'data' => $menus
        ]);
    }
} 