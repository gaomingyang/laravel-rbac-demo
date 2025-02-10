<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AdminRole extends Model
{
    use SoftDeletes;
    protected $table = 'admin_roles';
    protected $fillable = ['id','role_name','description','created_by'];

    public function menus()
    {
        return $this->hasMany(AdminRoleMenu::class);
    }

    public function permissions()
    {
        return $this->belongsToMany(AdminPermission::class, 'admin_role_permissions', 'role_id', 'permission_id');
    }

}