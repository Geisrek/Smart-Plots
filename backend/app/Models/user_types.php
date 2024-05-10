<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class user_types extends Model
{
    use HasFactory;
    protected $fillable = ["user_id",'user_type'];
    public function users(){
        return $this->belongsTo(User::class);
    }
}
