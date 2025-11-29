<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Models\Module;
use Spatie\Permission\Models\Permission;
use App\Models\Role;
use App\Models\Restaurant;


return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {

        $smsModule = Module::firstOrCreate(['name' => 'Sms']);

        $permissions = [
            'Update Sms Setting',
        ];

        foreach ($permissions as $name) {
            Permission::firstOrCreate([
                'guard_name' => 'web',
                'name' => $name,
                'module_id' => $smsModule->id,
            ]);
        }

        $allPermissions = Permission::where('module_id', $smsModule->id)->get()->pluck('name')->toArray();
        $restaurants = Restaurant::select('id')->get();

        foreach ($restaurants as $restaurant) {
            $adminRole = Role::where('name', 'Admin_' . $restaurant->id)->first();
            $branchHeadRole = Role::where('name', 'Branch Head_' . $restaurant->id)->first();

            if ($adminRole) {
                $adminRole->givePermissionTo($allPermissions);
            }
            if ($branchHeadRole) {
                $branchHeadRole->givePermissionTo($allPermissions);
            }
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        $smsModule = Module::where('name', 'Sms')->first();

        if ($smsModule) {
            $permissions = Permission::where('module_id', $smsModule->id)->delete();
        }
    }
};
