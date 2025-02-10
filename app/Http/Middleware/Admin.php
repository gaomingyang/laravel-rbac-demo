<?php
/**
 * admin账号浏览范围限制中间件
 */

namespace App\Http\Middleware;

use App\Models\AdminUser;
use App\Repositories\PermissionRepository;
use Closure;
use Illuminate\Support\Facades\Log;

class Admin
{
	/**
	 * 检查权限
	 * @param $request
	 * @return bool
	 * @throws \Psr\SimpleCache\InvalidArgumentException
	 */
	protected function checkPermission($request)
	{
		//对于restful的接口，path包含数字的，数字替换成*
		$request_method = $request->method();
		$request_path = $request->path();
		$path_arr = explode('/',$request_path);
		array_walk($path_arr,function (&$item){
			if(is_numeric($item)){
				$item = '*';
			}
		});
		$path = implode('/',$path_arr);
		$action = strtolower($request_method).'@'.$path;
		$permission_urls = (new PermissionRepository())->getUserPermission();
		if (in_array($action,$permission_urls)){
			return true;
		}
		return false;
	}
	/**
	 * Handle an incoming request.
	 *
	 * @param \Illuminate\Http\Request $request
	 * @param Closure $next
	 *
	 * @return \Illuminate\Http\JsonResponse|mixed
	 * @throws \Exception
	 */
	public function handle($request, Closure $next)
	{
		//before
		$user = auth('admin')->user();
		Log::info("user:".json_encode($user,JSON_UNESCAPED_UNICODE));
		if (empty($user) || $user->status != 1) {
			$data = [
				'code'     => 10004,
				'msg'      => trans('errors.10004'),
				// 'trace_id' => trace_id(),
				'data'     => [],
			];
			return response()->json($data);
		}

		//获取用户身份、账号类型
		switch ($user->type) {
			case AdminUser::USER_TYPE_ADMIN:  //超级管理员
				$attachParams = [
					// 'user_type' => 'admin',  //可选，附加用户类型
				];
				break;
			case AdminUser::USER_TYPE_NORMAL: //普通用户
				$attachParams = [
					// 'user_type' => 'normal',
				];
				$role_id = $user->role_id;
				//中间件增加权限判断
				if(config('app.verify_permission') == true){
					$check = $this->checkPermission($request);
					if (!$check){
						$data = [
							'code'     => 10006,
							'msg'      => trans('errors.10006'),
							// 'trace_id' => trace_id(),
							'data'     => [],
						];
						return response()->json($data);
					}
				}
				break;
			default:
				$data = [
					'code'     => 11004,
					'msg'      => trans('errors.11004'),
					'trace_id' => trace_id(),
					'data'     => [],
				];
				return response()->json($data);
		}
		$request->merge($attachParams);
		$response = $next($request);
		//after
		return $response;
	}


}
