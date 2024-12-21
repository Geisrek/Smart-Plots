<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserPlots extends Model
{
    use HasFactory;
    protected $table = 'smart_plots';
    protected $fillable=['user_id','product','address','IP'];

    public function User(){
        return $this->belongsTo(User::class);
    }
    public function tasks(){
        return $this->hasMany(Tasks::class,'plot_id');
    }
   
}
