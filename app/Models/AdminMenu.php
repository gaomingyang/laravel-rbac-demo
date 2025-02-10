<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AdminMenu extends Model
{
	protected $table = 'admin_menus';
	protected $timestamp = false;

	protected $fillable = [
		'parent_id',
		'name',
		'path',
		'icon',
		'sort',
		'status'
	];

	// 获取子菜单
	public function children()
	{
		return $this->hasMany(AdminMenu::class, 'parent_id', 'id');
	}

	// 获取父菜单
	public function parent()
	{
		return $this->belongsTo(AdminMenu::class, 'parent_id');
	}

	// 与角色的多对多关联
	public function roles()
	{
		return $this->belongsToMany(AdminRole::class, 'admin_role_menus', 'menu_id', 'role_id');
	}
}