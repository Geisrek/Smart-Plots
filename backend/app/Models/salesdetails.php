<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class salesdetails extends Model
{
    use HasFactory;
    protected $table="salesdetails";
    protected $fillable=['client_id','product_serial','product_id','opened','cost','currency_unit','product'];
}
