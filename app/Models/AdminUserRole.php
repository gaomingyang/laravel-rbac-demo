<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AdminUserRole extends Model
{
    use SoftDeletes;
	public $timestamps = false;
    protected $table = 'admin_user_roles';
    protected $fillable = ['id', 'user_id', 'role_id'];

}
