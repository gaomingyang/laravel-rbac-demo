<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AdminPermission extends Model
{
    protected $table = 'admin_permissions';
    protected $timestamp = false;

    protected $fillable = ['id','action','description', 'created_by'];

}