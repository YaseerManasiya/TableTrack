<?php

use Illuminate\Support\Facades\Route;
use Modules\RestApi\Http\Controllers\AppWideController;
use Modules\RestApi\Http\Controllers\AuthController;
use Modules\RestApi\Http\Controllers\CustomerController;
use Modules\RestApi\Http\Controllers\MultiPosIntegrationController;
use Modules\RestApi\Http\Controllers\NotificationController;
use Modules\RestApi\Http\Controllers\PlatformController;
use Modules\RestApi\Http\Controllers\PosProxyController;
use Modules\RestApi\Http\Middleware\EnsurePosFeatureEnabled;

Route::middleware('api')->prefix('api/application-integration')->group(function () {
    // Auth endpoints for apps - rate limited to prevent brute force attacks
    Route::middleware(['throttle:5,1'])->post('/auth/login', [AuthController::class, 'login']);

    Route::middleware(['auth:sanctum', EnsurePosFeatureEnabled::class])->group(function () {
        Route::get('/auth/me', [AuthController::class, 'me']);

        // Platform/system wide
        Route::prefix('platform')->group(function () {
            Route::get('/config', [PlatformController::class, 'config']);
            Route::get('/permissions', [PlatformController::class, 'permissions']);
            Route::get('/printers', [PlatformController::class, 'printers']);
            Route::get('/receipt-settings', [PlatformController::class, 'receiptSettings']);
            Route::post('/switch-branch', [PlatformController::class, 'switchBranch']);
        });

        // Shared/global
        Route::get('/languages', [AppWideController::class, 'languages']);
        Route::get('/currencies', [AppWideController::class, 'currencies']);
        Route::get('/payment-gateways', [AppWideController::class, 'paymentGateways']);
        Route::get('/staff', [AppWideController::class, 'staff']);
        Route::get('/roles', [AppWideController::class, 'roles']);
        Route::get('/areas', [AppWideController::class, 'areas']);
        Route::get('/customer-addresses', [AppWideController::class, 'customerAddresses']);
        Route::post('/customer-addresses', [AppWideController::class, 'storeCustomerAddress']);
        Route::put('/customer-addresses/{id}', [AppWideController::class, 'updateCustomerAddress']);
        Route::delete('/customer-addresses/{id}', [AppWideController::class, 'deleteCustomerAddress']);

        // Customer app endpoints (delivery/dine-in)
        Route::prefix('customer')->group(function () {
            Route::get('/catalog', [CustomerController::class, 'catalog']);
            Route::post('/orders', [CustomerController::class, 'placeOrder']);
            Route::get('/orders', [CustomerController::class, 'myOrders']);
        });

        // POS endpoints proxied to existing controller
        Route::prefix('pos')->group(function () {
            Route::get('/menus', [PosProxyController::class, 'getMenus']);
            Route::get('/categories', [PosProxyController::class, 'getCategories']);
            Route::get('/items', [PosProxyController::class, 'getMenuItems']);
            Route::get('/items/category/{categoryId}', [PosProxyController::class, 'getMenuItemsByCategory']);
            Route::get('/items/menu/{menuId}', [PosProxyController::class, 'getMenuItemsByMenu']);
            Route::get('/items/{itemId}/variations', [PosProxyController::class, 'getMenuItemVariations']);
            Route::get('/items/{itemId}/modifier-groups', [PosProxyController::class, 'getMenuItemModifierGroups']);
            Route::get('/extra-charges/{orderType}', [PosProxyController::class, 'getExtraCharges']);
        Route::get('/tables', [PosProxyController::class, 'getTables']);
        Route::post('/tables/{tableId}/unlock', [PosProxyController::class, 'forceUnlockTable']);
        Route::get('/reservations/today', [PosProxyController::class, 'getTodayReservations']);
        Route::get('/order-types', [PosProxyController::class, 'getOrderTypes']);
        Route::get('/actions', [PosProxyController::class, 'getActions']);
        Route::get('/delivery-platforms', [PosProxyController::class, 'getDeliveryPlatforms']);
        Route::get('/get-order-number', [PosProxyController::class, 'getOrderNumber']);
        Route::post('/orders', [PosProxyController::class, 'submitOrder']);
        Route::put('/orders/{id}', [PosProxyController::class, 'updateOrder']);  // Update existing order
        Route::get('/orders', [PosProxyController::class, 'getOrders']);
        Route::get('/orders/{id}', [PosProxyController::class, 'getOrder']);
        Route::post('/orders/{id}/status', [PosProxyController::class, 'updateOrderStatus']);
        Route::post('/orders/{id}/tip', [PosProxyController::class, 'addTip']);
        Route::post('/orders/{id}/split-payments', [PosProxyController::class, 'addSplitPayment']);
        Route::post('/orders/{id}/pay', [PosProxyController::class, 'payOrder']);
        
        // New: Update order items and create KOT
        Route::put('/orders/{id}/items', [PosProxyController::class, 'updateOrderItems']);
        Route::post('/orders/{id}/kot', [PosProxyController::class, 'createKot']);
        Route::get('/orders/{id}/kots', [PosProxyController::class, 'getOrderKots']);

        // KOT Management endpoints
        Route::get('/kots', [PosProxyController::class, 'getKots']);
        Route::get('/kots/{id}', [PosProxyController::class, 'getKot']);
        Route::put('/kots/{id}/status', [PosProxyController::class, 'updateKotStatus']);
        Route::put('/kot-items/{id}/status', [PosProxyController::class, 'updateKotItemStatus']);
        Route::get('/kot-places', [PosProxyController::class, 'getKotPlaces']);
        Route::get('/kot-cancel-reasons', [PosProxyController::class, 'getKotCancelReasons']);
        
        Route::get('/customers', [PosProxyController::class, 'getCustomers']);
        Route::get('/phone-codes', [PosProxyController::class, 'getPhoneCodes']);
        Route::post('/customers', [PosProxyController::class, 'saveCustomer']);
        Route::get('/taxes', [PosProxyController::class, 'getTaxes']);
            Route::get('/restaurants', [PosProxyController::class, 'getRestaurants']);
        Route::get('/branches', [PosProxyController::class, 'getBranches']);
            Route::get('/reservations', [PosProxyController::class, 'listReservations']);
            Route::post('/reservations', [PosProxyController::class, 'createReservation']);
            Route::post('/reservations/{id}/status', [PosProxyController::class, 'updateReservationStatus']);
            Route::get('/waiters', [PosProxyController::class, 'getWaiters']);
            Route::get('/delivery-executives', [PosProxyController::class, 'getDeliveryExecutives']);

            // Delivery Management endpoints
            Route::get('/delivery-settings', [PosProxyController::class, 'getDeliverySettings']);
            Route::post('/delivery-fee/calculate', [PosProxyController::class, 'calculateDeliveryFee']);
            Route::get('/delivery-fee-tiers', [PosProxyController::class, 'getDeliveryFeeTiers']);
            Route::get('/delivery-platforms/{id}', [PosProxyController::class, 'getDeliveryPlatform']);
            Route::post('/delivery-platforms', [PosProxyController::class, 'createDeliveryPlatform']);
            Route::put('/delivery-platforms/{id}', [PosProxyController::class, 'updateDeliveryPlatform']);
            Route::delete('/delivery-platforms/{id}', [PosProxyController::class, 'deleteDeliveryPlatform']);
            Route::post('/delivery-executives', [PosProxyController::class, 'createDeliveryExecutive']);
            Route::put('/delivery-executives/{id}', [PosProxyController::class, 'updateDeliveryExecutive']);
            Route::delete('/delivery-executives/{id}', [PosProxyController::class, 'deleteDeliveryExecutive']);
            Route::put('/delivery-executives/{id}/status', [PosProxyController::class, 'updateDeliveryExecutiveStatus']);
            Route::put('/orders/{id}/assign-delivery', [PosProxyController::class, 'assignDeliveryExecutive']);
            Route::put('/orders/{id}/delivery-status', [PosProxyController::class, 'updateDeliveryOrderStatus']);
            Route::get('/delivery-orders', [PosProxyController::class, 'getDeliveryOrders']);

            // Notifications (push + in-app)
            Route::post('/notifications/register-token', [NotificationController::class, 'registerToken']);
            Route::get('/notifications', [NotificationController::class, 'list']);
            Route::post('/notifications/{id}/read', [NotificationController::class, 'markRead']);
            Route::post('/notifications/test', [NotificationController::class, 'sendTest']);

            // MultiPOS device registration (optional; only works if MultiPOS module is enabled)
            Route::post('/multi-pos/register', [MultiPosIntegrationController::class, 'register']);
            Route::get('/multi-pos/check', [MultiPosIntegrationController::class, 'check']);
        });
    });
});

