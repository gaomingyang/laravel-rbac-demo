<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AuthController extends Controller
{
	public function auth(Request $request)
	{
		$credentials['username'] = $request->get('username');
		$credentials['password'] = $request->get('password');

		if (!$token = auth()->attempt($credentials)) {
			return $this->error(11001);
		}


		$data = [
			'access_token' => $token,
			'token_type'   => 'bearer',
			'expires_in'   => auth()->factory()->getTTL() * 60
		];
		return $this->success($data);
	}
}
