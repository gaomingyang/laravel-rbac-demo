<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AdminUserPermission extends Model
{
    use SoftDeletes;
	public $timestamps = false;
    protected $table = 'admin_user_permissions';
    protected $fillable = ['id', 'user_id', 'permission_id'];

}
