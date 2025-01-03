<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class history extends Model
{
    use HasFactory;
    protected $table = 'history';
    protected $fillable=['light','sol_humidity','air_humidity','temperature','schedule_date','plot_id'];
}
