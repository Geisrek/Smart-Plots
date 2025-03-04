<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class sales extends Model
{
    use HasFactory;
    protected $table="sales";
    protected $primaryKey = 'sales_id';
    protected $fillable=["cost","product","plot_id","product_serial","supplier_id","currency_unit"];
}
