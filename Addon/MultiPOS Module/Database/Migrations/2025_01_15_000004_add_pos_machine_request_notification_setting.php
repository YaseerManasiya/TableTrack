<?php

use App\Models\NotificationSetting;
use App\Models\Restaurant;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {

    /**
     * Run the migrations.
     */
    public function up(): void
    {
        $checkCount = Restaurant::count();

        if ($checkCount > 0) {
            $restaurants = Restaurant::select('id')->get();

            foreach ($restaurants as $restaurant) {
                // Check if notification setting already exists to avoid duplicates
                $existing = NotificationSetting::where('type', 'pos_machine_request')
                    ->where('restaurant_id', $restaurant->id)
                    ->first();

                if (!$existing) {
                    NotificationSetting::create([
                        'type' => 'pos_machine_request',
                        'send_email' => 1,
                        'restaurant_id' => $restaurant->id
                    ]);
                }
            }
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        NotificationSetting::where('type', 'pos_machine_request')->delete();
    }

};
