<?php

namespace Modules\MultiPOS\Listeners;

use Modules\MultiPOS\Events\PosMachineRegistrationRequested;
use Modules\MultiPOS\Notifications\PosMachineRegistrationRequest;
use App\Models\User;
use App\Scopes\BranchScope;
use App\Http\Controllers\DashboardController;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Support\Facades\Notification;
use Illuminate\Support\Facades\Log;

class SendPosMachineRegistrationNotification implements ShouldQueue
{
    use InteractsWithQueue;

    /**
     * Create the event listener.
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     */
    public function handle(PosMachineRegistrationRequested $event): void
    {
        $posMachine = $event->posMachine;
        $restaurant = $posMachine->branch->restaurant;

        // Get all admin users for this restaurant
        $adminUsers = User::role('Admin_' . $restaurant->id)
            ->where('restaurant_id', $restaurant->id)
            ->withoutGlobalScope(BranchScope::class)
            ->get();

        if ($adminUsers->isEmpty()) {
            Log::warning('No admin users found for POS machine registration notification', [
                'restaurant_id' => $restaurant->id,
                'pos_machine_id' => $posMachine->id,
            ]);
            return;
        }

        try {
            Log::info('Sending POS machine registration notifications', [
                'pos_machine_id' => $posMachine->id,
                'restaurant_id' => $restaurant->id,
                'admin_count' => $adminUsers->count(),
                'admin_emails' => $adminUsers->pluck('email')->toArray(),
            ]);

            // Send email and database notifications
            foreach ($adminUsers as $admin) {
                try {
                    $notification = new PosMachineRegistrationRequest($posMachine);
                    $admin->notify($notification);
                    
                    Log::info('Notification sent to admin', [
                        'admin_id' => $admin->id,
                        'admin_email' => $admin->email,
                        'channels' => $notification->via($admin),
                    ]);
                } catch (\Exception $e) {
                    Log::error('Error sending notification to individual admin', [
                        'admin_id' => $admin->id,
                        'admin_email' => $admin->email,
                        'error' => $e->getMessage(),
                    ]);
                }
            }

            // Send push notifications
            try {
                $pushNotification = new DashboardController();
                $pushUsersIds = [$adminUsers->pluck('id')->toArray()];
                $settingsUrl = route('settings.index') . '?tab=multipos';
                
                $pushNotification->sendPushNotifications(
                    $pushUsersIds,
                    __('multipos::messages.notifications.pos_request.push_title'),
                    __('multipos::messages.notifications.pos_request.push_message', [
                        'alias' => $posMachine->alias ?? __('multipos::messages.table.no_alias'),
                        'branch' => $posMachine->branch->name
                    ]),
                    $settingsUrl
                );
                
                Log::info('Push notifications sent', [
                    'user_ids' => $pushUsersIds,
                ]);
            } catch (\Exception $e) {
                Log::error('Error sending push notifications', [
                    'error' => $e->getMessage(),
                ]);
            }

            Log::info('POS machine registration notification process completed', [
                'pos_machine_id' => $posMachine->id,
                'restaurant_id' => $restaurant->id,
                'admin_count' => $adminUsers->count(),
            ]);
        } catch (\Exception $e) {
            Log::error('Error in POS machine registration notification listener: ' . $e->getMessage(), [
                'pos_machine_id' => $posMachine->id,
                'restaurant_id' => $restaurant->id,
                'error' => $e->getTraceAsString(),
            ]);
        }
    }
}
