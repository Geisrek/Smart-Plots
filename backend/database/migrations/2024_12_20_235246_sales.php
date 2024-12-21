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
        Schema::create("sales",function(Blueprint $table){
            $table->id("sales_id");
            $table->unsignedBigInteger("cost");
            $table->string("product");
            $table->unsignedBigInteger("plot_id");
            $table->string("product_serial");
            $table->unsignedBigInteger("supplier_id");
            $table->foreign("supplier_id")->references("id")->on("users");
            $table->timestamp('last_used_at')->nullable();
            $table->timestamp('expires_at')->nullable();
            $table->timestamps();

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
