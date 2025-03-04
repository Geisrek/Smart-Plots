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
        Schema::table('sales', function (Blueprint $table) { 
            $table->unsignedBigInteger('plot_id')->change(); 
             $table->dropForeign(['plot_id']); 
              $table->foreign('plot_id')->references('id')->on('smart_plots')->onDelete('cascade');
             });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('sales', function (Blueprint $table) {
            $table->dropForeign(['plot_id']); 
            $table->foreign('plot_id')->references('id')->on('smart_plots');
    });
    }
};
