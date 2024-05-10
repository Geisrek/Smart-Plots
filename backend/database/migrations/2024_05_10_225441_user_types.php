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
        Schema::create('user_types',function(Blueprint $table){
          $table->id();
          $table->unsignedBigInteger("user_id");
          $table->foreign("user_id")->references("id")->on("users");
          $table->enum("user_type",["farmer","vendor","client"]);
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
