<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class AdminUser extends Authenticatable implements JWTSubject
{
    use SoftDeletes;
    protected $table = 'admin_users';
    protected $fillable = [
        'username',
        'password',
        'name',
        'email',
        'status',
    ];

    protected $hidden = [
        'password',
    ];

    use Notifiable;

    //type admin/normal. 这里是因为管理员和普通用户放在一个表，如果不放在一个表，type可以不用。
    const USER_TYPE_ADMIN   = 1; // 管理员
    const USER_TYPE_NORMAL   = 2; // 普通用户

    // JWT 所需方法
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }

    // 与角色的关联关系
    public function roles(): BelongsToMany
    {
        return $this->belongsToMany(AdminRole::class, 'admin_user_roles', 'user_id', 'role_id');
    }

    // 检查用户是否有指定权限
    public function hasPermission(string $action): bool
    {
        return $this->roles()
            ->with('permissions')
            ->get()
            ->flatMap(function ($role) {
                return $role->permissions;
            })
            ->pluck('action')
            ->contains($action);
    }
}
