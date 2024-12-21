<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tasks extends Model
{
    use HasFactory;
    protected $table = 'tasks';
    protected $fillable=['light','sol_humidity','air_humidity','temperature','schedule_date','plot_id','user_id'];
    public function plots(){
        return $this->belongsTo(UserPlots::class);
    }
}
