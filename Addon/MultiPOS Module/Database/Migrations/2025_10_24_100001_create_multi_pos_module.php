<?php

use Illuminate\Database\Migrations\Migration;
use App\Models\Module;
use App\Models\Package;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use App\Models\Restaurant;
use Modules\MultiPOS\Entities\MultiPOSGlobalSetting;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        $multiPOSModule = Module::firstOrCreate(['name' => MultiPOSGlobalSetting::MODULE_NAME]);

        $permissions = [
            'Manage MultiPOS Machines',
        ];

        foreach ($permissions as $name) {
            Permission::firstOrCreate([
                'guard_name' => 'web',
                'name' => $name,
                'module_id' => $multiPOSModule->id,
            ]);
        }

        $allPermissions = Permission::where('module_id', $multiPOSModule->id)->pluck('name')->toArray();
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

        // Add MultiPOS module to all existing packages
        $packages = Package::all();
        foreach ($packages as $package) {
            // Add MultiPOS to package modules if not already attached
            if (!$package->modules()->where('modules.id', $multiPOSModule->id)->exists()) {
                $package->modules()->attach($multiPOSModule->id);
            }
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        $multiPOSModule = Module::where('name', 'MultiPOS')->first();

        if ($multiPOSModule) {
            $permissions = Permission::where('module_id', $multiPOSModule->id)->delete();
        }
    }
};
