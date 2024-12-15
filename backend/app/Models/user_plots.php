<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class user_plots extends Model
{
    use HasFactory;
    protected $table = 'smart_plots';
    protected $fillable=['user_id','product','address','IP'];
}
