<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\SoftDeletes;

class AdminUser extends Model
{
    use SoftDeletes;
    protected $table = 'admin_users';
    protected $fillable = ['id', 'type', 'username', 'password', 'email', 'status'];

    use Notifiable;

    //type admin/normal. 这里是因为管理员和普通用户放在一个表，如果不放在一个表，type可以不用。
    const USER_TYPE_ADMIN   = 1; // 管理员
    const USER_TYPE_NORMAL   = 2; // 普通用户

    // 用户的角色
    public function roles()
    {
        return $this->hasMany('App\Models\AdminRole','id','role_id');
    }
}
