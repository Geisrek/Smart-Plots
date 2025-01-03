<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
      Schema::create('card',function(Blueprint $table){
        $table->id("card_id");
        $table->unsignedBigInteger("detail_id");
        $table->foreign("detail_id")->references("id")->on("salesdetails");
        $table->unsignedBigInteger("product_id");
        $table->
      });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};
