<?php

if (!function_exists('get_server_ip')) {
	/**
	 * 获取服务器ip
	 *
	 * @return string
	 */
	function get_server_ip()
	{
		if (isset($_SERVER['SERVER_IP_AUTO'])) {
			return $_SERVER['SERVER_IP_AUTO'];
		}
		if (!empty($_SERVER['SERVER_ADDR'])) {
			$_SERVER['SERVER_IP_AUTO'] = $_SERVER['SERVER_ADDR'] ?? '';
		}
		return $_SERVER['SERVER_IP_AUTO'] ?? '';
	}
}

if (!function_exists('trace_id')) {
	/**
	 * 获取或生成trace_id
	 *
	 * @return string
	 * @throws Exception
	 */
	function trace_id()
	{
		if (isset($_SERVER['TRACE_ID'])) {
			return $_SERVER['TRACE_ID'];
		}
		list($usec, $sec) = explode(" ", microtime());
		$usec = sprintf("%.3f", $usec);
		$usec = substr($usec, 2);
		$rand_int = random_int(1, 10000);
		$trace_id = request('trace_id') ? request('trace_id') : ('api_' . $sec . $usec . $rand_int);
		$_SERVER['TRACE_ID'] = $trace_id;
		return $trace_id;
	}
}