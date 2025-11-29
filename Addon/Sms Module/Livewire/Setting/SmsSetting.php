<?php

namespace Modules\Sms\Livewire\Setting;

use Livewire\Component;
use Jantinnerezo\LivewireAlert\LivewireAlert;
use Modules\Sms\Entities\SmsNotificationSetting;
use Modules\Sms\Entities\SmsUsageLog;
use App\Models\Restaurant;
use App\Models\GlobalSubscription;

class SmsSetting extends Component
{
    use LivewireAlert;
    
    public $notificationSettings;
    public $sendEmail;
    public $activeGateway;
    public $activeGatewayName;
    public $smsCounts = [];

    public $packageSmsCount;
    public $usedSmsCount;
    public $remainingSmsCount;
    public $isSmsLimitReached;
    
    // Modal properties
    public $showViewModal = false;
    public $selectedNotificationType = '';
    public $notificationDetails = [];

    public function mount()
    {
        // Get SMS notification settings
        $this->notificationSettings = SmsNotificationSetting::get();
        $this->sendEmail = $this->notificationSettings->map(function($item) {
            return $item->send_sms === 'yes';
        })->toArray();
        
        // Get active SMS gateway
        $this->getActiveGateway();
        $this->getSmsCountInfo();
        $this->getSmsCountsForNotifications();
    }

    public function submitForm()
    {
        foreach ($this->notificationSettings as $key => $notification) {
            $notification->update(['send_sms' => $this->sendEmail[$key] ? 'yes' : 'no']);
        }

        $this->alert('success', __('messages.settingsUpdated'), [
            'toast' => true,
            'position' => 'top-end',
            'showCancelButton' => false,
            'cancelButtonText' => __('app.close')
        ]);
    }

    public function openViewModal($notificationType)
    {
        $this->selectedNotificationType = $notificationType;
        $this->notificationDetails = $this->getNotificationDetails($notificationType);
        $this->showViewModal = true;
    }

    private function getNotificationDetails($notificationType)
    {
        $notification = $this->notificationSettings->where('type', $notificationType)->first();
        
        if (!$notification) {
            return [];
        }
        
        $details = [
            'type' => $notificationType,
            'title' => __('sms::modules.notifications.' . $notificationType),
            'description' => __('sms::modules.notifications.' . $notificationType . '_info'),
            'is_enabled' => $notification->send_sms === 'yes',
            'sms_message' => '',
            'gateway_info' => []
        ];

        // Get SMS message based on notification type and gateway
        if (sms_setting()->vonage_status) {
            $details['sms_message'] = $this->getVonageSmsMessage($notificationType);
        } elseif (sms_setting()->msg91_status) {
            $details['sms_message'] = $this->getMsg91SmsMessage($notificationType);
        }

        return $details;
    }

    private function getVonageSmsMessage($notificationType)
    {
        $vonageMessages = [
            'reservation_confirmed' => __('sms::modules.messages.reservation_confirmed'),
            'order_bill_sent' => __('sms::modules.messages.order_bill_sent'),
            'send_otp' => __('sms::modules.messages.send_otp')
        ];

        return $vonageMessages[$notificationType] ?? 'No message template available for this notification type.';
    }

    private function getMsg91SmsMessage($notificationType)
    {
        $msg91Messages = [
            'reservation_confirmed' => 'Hello ##customer_name##, your reservation is confirmed at ##restaurant_name##. Reservation Date & Time: ##reservation_date_time##. Thank you!',
            'order_bill_sent' => 'Hello ##customer_name##, Thank you for dining with us at ##restaurant_name##! It was our pleasure to serve you!. Order: ##order_number##. Total: ##order_total##. Thank you!',
            'send_otp' => '##var## is the OTP to access your account. Do not share it with anyone.'
        ];

        return $msg91Messages[$notificationType] ?? 'No message template available for this notification type.';
    }

    public function getActiveGateway()
    {
        $globalSettings = \Modules\Sms\Entities\SmsGlobalSetting::first();
        
        if ($globalSettings) {
            if ($globalSettings->vonage_status) {
                $this->activeGateway = 'vonage';
                $this->activeGatewayName = 'Vonage';
            } elseif ($globalSettings->msg91_status) {
                $this->activeGateway = 'msg91';
                $this->activeGatewayName = 'MSG91';
            } else {
                $this->activeGateway = null;
                $this->activeGatewayName = null;
            }
        }
    }

    public function getSmsCountInfo()
    {
        $restaurant = Restaurant::find(auth()->user()->restaurant_id);
        
        if ($restaurant) {
            // Use restaurant's total_sms instead of package sms_count
            $this->packageSmsCount = $restaurant->total_sms ?? 0;
            $this->usedSmsCount = $restaurant->count_sms ?? 0;
            
            // Check if SMS count is unlimited (-1)
            if ($this->packageSmsCount == -1) {
                $this->remainingSmsCount = -1; // -1 indicates unlimited
                $this->isSmsLimitReached = false;
            } else {
                $this->remainingSmsCount = max(0, $this->packageSmsCount - $this->usedSmsCount);
                $this->isSmsLimitReached = $this->usedSmsCount >= $this->packageSmsCount;
            }
        } else {
            $this->packageSmsCount = 0;
            $this->usedSmsCount = 0;
            $this->remainingSmsCount = 0;
            $this->isSmsLimitReached = false;
        }
    }

    /**
     * Get active subscription for the restaurant
     */
    private function getActiveSubscription($restaurantId)
    {
        return GlobalSubscription::where('restaurant_id', $restaurantId)
            ->where('subscription_status', 'active')
            ->orderBy('subscribed_on_date', 'desc')
            ->first();
    }

    /**
     * Get SMS counts for each notification type based on active subscription
     * Only count records after subscription start date and for current package
     */
    public function getSmsCountsForNotifications()
    {
        $restaurant = Restaurant::find(auth()->user()->restaurant_id);
        
        if (!$restaurant) {
            $this->smsCounts = [];
            return;
        }

        $restaurantId = $restaurant->id;
        $currentPackageId = $restaurant->package_id;
        
        // Get active subscription
        $activeSubscription = $this->getActiveSubscription($restaurantId);
        
        if (!$activeSubscription) {
            $this->smsCounts = [];
            return;
        }

        $subscriptionStartDate = $activeSubscription->subscribed_on_date;
        
        // Initialize counts for all notification types
        $this->smsCounts = [];
        
        foreach ($this->notificationSettings as $notification) {
            $type = $notification->type;
            $count = 0;
            
            // Get count based on active gateway, current package, and after subscription start date
            if ($this->activeGateway === 'vonage') {
                $count = SmsUsageLog::where('restaurant_id', $restaurantId)
                    ->where('gateway', 'vonage')
                    ->where('type', $type)
                    ->where('package_id', $currentPackageId)
                    ->where('date', '>=', $subscriptionStartDate)
                    ->sum('count');
            } elseif ($this->activeGateway === 'msg91') {
                $count = SmsUsageLog::where('restaurant_id', $restaurantId)
                    ->where('gateway', 'msg91')
                    ->where('type', $type)
                    ->where('package_id', $currentPackageId)
                    ->where('date', '>=', $subscriptionStartDate)
                    ->sum('count');
            }
            
            $this->smsCounts[$type] = $count;
        }
    }

    /**
     * Get SMS count for a specific notification type
     */
    public function getSmsCountForType($type)
    {
        return $this->smsCounts[$type] ?? 0;
    }

    /**
     * Refresh SMS counts (useful for real-time updates)
     */
    public function refreshSmsCounts()
    {
        $this->getSmsCountsForNotifications();
    }

    /**
     * Get total SMS count for current subscription period
     */
    public function getTotalSmsCountForCurrentPackage()
    {
        $restaurant = Restaurant::find(auth()->user()->restaurant_id);
        
        if (!$restaurant) {
            return 0;
        }

        $restaurantId = $restaurant->id;
        $currentPackageId = $restaurant->package_id;
        
        // Get active subscription
        $activeSubscription = $this->getActiveSubscription($restaurantId);
        
        if (!$activeSubscription) {
            return 0;
        }

        $subscriptionStartDate = $activeSubscription->subscribed_on_date;
        
        return SmsUsageLog::where('restaurant_id', $restaurantId)
            ->where('package_id', $currentPackageId)
            ->where('date', '>=', $subscriptionStartDate)
            ->sum('count');
    }

    /**
     * Get SMS count by gateway for current subscription period
     */
    public function getSmsCountByGatewayForCurrentPackage($gateway)
    {
        $restaurant = Restaurant::find(auth()->user()->restaurant_id);
        
        if (!$restaurant) {
            return 0;
        }

        $restaurantId = $restaurant->id;
        $currentPackageId = $restaurant->package_id;
        
        // Get active subscription
        $activeSubscription = $this->getActiveSubscription($restaurantId);
        
        if (!$activeSubscription) {
            return 0;
        }

        $subscriptionStartDate = $activeSubscription->subscribed_on_date;
        
        return SmsUsageLog::where('restaurant_id', $restaurantId)
            ->where('gateway', $gateway)
            ->where('package_id', $currentPackageId)
            ->where('date', '>=', $subscriptionStartDate)
            ->sum('count');
    }

    public function render()
    {
        return view('sms::livewire.setting.sms-setting');
    }
}
