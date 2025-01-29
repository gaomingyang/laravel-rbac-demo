<?php
/**
 * 权限仓库
 */

namespace App\Repositories;

use App\Models\AdminMenu;
use App\Models\AdminMenuPermission;
use App\Models\AdminPermission;
use App\Models\AdminRoleMenu;
use App\Models\AdminUser;
use App\Models\AdminUserRole;
use Illuminate\Support\Facades\Cache;

class PermissionRepository
{
	/**
	 * 返回用户权限范围的的菜单 uid->角色->菜单[->privilege]
	 * @throws \Exception
	 */
	public function getUserMenu()
	{
		$user = auth('admin')->user();
		$user_id = $user->user_id;
		$user_type = $user->type;
		if ($user_type == AdminUser::USER_TYPE_ADMIN) {
			$menus = $this->getMenus();
			return ['code' => 1, 'data' => $menus];
		}

		$user = AdminUser::query()->find($user_id);
		if (is_null($user)) {
			return ['code' => 0, 'msg' => '用户信息不合法'];
		}
		if (empty($user->role_id)) {
			return ['code' => 0, 'msg' => '此用户角色异常'];
		}
		$role_ids = AdminUserrole::query()->where('user_id', $user_id)->pluck('role_id')->toArray();
		$menu_ids = AdminRoleMenu::query()->whereIn("role_id", $role_ids)->pluck('admin_menu_id');
		$menus = $this->getMenus((array)$menu_ids);
		return ['code' => 1, 'data' => $menus];
	}



	/**
	 * 递归生成菜单树
	 * @param array $filterIds 只保留的id
	 * @return array
	 */
	public function getMenus(array $filterIds = [])
	{
		$menus = AdminMenu::query()->get()->toArray();
		//完整的菜单树
		$menuTree = $this->buildMenuTree($menus);
		// 如果提供了 filterIds，则筛选出匹配的菜单及其子菜单
		if (!empty($filterIds)) {
			$menuTree = $this->filterMenuTree($menuTree, $filterIds);
		}
		return $menuTree;
	}

	public function buildMenuTree(array $menus, int $parentId = 0): array
	{
		$branch = [];
		foreach ($menus as $menu) {
			if ($menu['parent_id'] == $parentId) {
				$children = $this->buildMenuTree($menus, $menu['id']);
				if ($children) {
					$menu['children'] = $children;
				}
				$branch[] = $menu;
			}
		}
		return $branch;
	}

	 function filterMenuTree(array $menuTree, array $filterIds): array
	{
		$filteredTree = [];

		foreach ($menuTree as $menu) {
			if (in_array($menu['id'], $filterIds)) {
				$filteredTree[] = $menu;
			} elseif (!empty($menu['children'])) {
				// 递归检查子菜单
				$filteredChildren = $this->filterMenuTree($menu['children'], $filterIds);
				if (!empty($filteredChildren)) {
					$menu['children'] = $filteredChildren;
					$filteredTree[] = $menu;
				}
			}
		}

		return $filteredTree;
	}





	/**
	 * 校区账号获取权限
	 * @return array
	 * @throws \Psr\SimpleCache\InvalidArgumentException
	 */
	public function getUserPermission()
	{
		$user = auth('admin')->user();
		if (is_null($user)) {
			return ['code' => 0, 'msg' => '用户信息不合法'];
		}
		$user_type = $user->type;
		$user_id = $user->id;
		$role_id = isset($user->role_id) ? $user->role_id : 0;
		if ($user_type == AdminUser::USER_TYPE_ORG_ADMIN || $user_type == AdminUser::USER_TYPE_ADMIN) {
			return ['code' => 1, 'data' => 'all'];
		}
		if (empty($role_id)) {
			return ['code' => 0, 'msg' => '此用户角色异常'];
		}
		//返回权限urls
		// 为测试先不用缓存
		// $permission_urls = Cache::get('user_permissions_' . $user_id);
		// if (!empty($permission_urls)) {
		//     return $permission_urls;
		// }
		$menu_ids = AdminRoleMenu::query()
			->where("admin_role_id", $role_id)
			->pluck('admin_menu_id');
		$permission_ids = AdminMenuPermission::query()
			->whereIn("admin_menu_id", $menu_ids)
			->pluck('admin_permission_id');
		$permission_urls = AdminPermission::query()
			->whereIn("id", $permission_ids)
			->pluck("action")->toArray();

		//公共path，无需鉴权
		$common_urls = [
			'get@api/admin/auth/me',
			'get@api/admin/auth/login',
			'get@api/admin/auth/admin-login',
			'get@api/admin/auth/logout',
			'get@api/admin/auth/refresh',
			'get@api/admin/menu/menu',
		];
		$permission_urls = array_merge($permission_urls,$common_urls);
		// Cache::set('user_permissions_' . $user_id, $permission_urls, 60 * 24);
		return $permission_urls;
	}

}