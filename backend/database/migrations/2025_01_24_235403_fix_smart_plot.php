<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::table('smart_plots', function (Blueprint $table) {
    
            $table->dropForeign(['user_id']);
            
          
            $table->foreign('user_id')->references('id')->on('users');
        });
    }
    
    public function down()
    {
        Schema::table('smart_plots', function (Blueprint $table) {
            
            $table->dropForeign(['user_id']);
            $table->foreign('user_id')->references('user_id')->on('user_types');
        });
    }
    
};
