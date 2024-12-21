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
        Schema::table('tasks', function (Blueprint $table) { 
             $table->dropForeign(['plot_id']);
              $table->unsignedBigInteger('plot_id')->change(); 
              $table->foreign('plot_id')->references('id')->on('smart_plots')->onDelete('cascade'); });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('tasks', function (Blueprint $table) { 
            $table->dropForeign(['plot_id']); 
            $table->foreign('plot_id')->references('id')->on('smart_plots'); });
    }
};
