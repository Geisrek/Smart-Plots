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
        Schema::create('tasks', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("light");
            $table->unsignedBigInteger("sol_humidity");
            $table->unsignedBigInteger("air_humidity");
            $table->unsignedBigInteger("temperature");
            $table->date("schedule_date");
            $table->unsignedBigInteger("plot_id");
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tasks');
    }
};
