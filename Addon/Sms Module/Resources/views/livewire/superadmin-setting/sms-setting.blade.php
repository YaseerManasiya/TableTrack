<div class="p-4 bg-white block  dark:bg-gray-800 dark:border-gray-700">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <!-- Header -->
        <div class="mb-3">
            <h3 class="text-2xl font-bold text-gray-900 dark:text-white">{{ __('sms::modules.menu.smsSettings') }}</h3>
        </div>
    </div>

    <!-- SMS Usage Widgets Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">

        <!-- Widget 1: Vonage Total Count -->
        <div class="items-center justify-between p-4 bg-white border border-gray-200 rounded-lg shadow-sm sm:flex dark:border-gray-700 sm:p-6 dark:bg-gray-800">
            <div class="w-full">
                <h3 class="text-base font-normal text-gray-500 dark:text-gray-400">@lang('sms::modules.form.vonage')</h3>
                <span class="text-2xl font-bold leading-none text-purple-600 sm:text-3xl dark:text-purple-400">{{ $vonageTotalCount }}</span>
                <p class="flex items-center text-base font-normal text-gray-500 dark:text-gray-400">
                    <span class="flex items-center mr-1.5 text-sm text-purple-500 dark:text-purple-400">
                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                            <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"></path>
                            <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"></path>
                        </svg>
                    </span>
                    @lang('sms::modules.sms.totalSmsSentViaVonage')
                </p>
            </div>
        </div>

        <!-- Widget 2: MSG91 Total Count -->
        <div class="items-center justify-between p-4 bg-white border border-gray-200 rounded-lg shadow-sm sm:flex dark:border-gray-700 sm:p-6 dark:bg-gray-800">
            <div class="w-full">
                <h3 class="text-base font-normal text-gray-500 dark:text-gray-400">@lang('sms::modules.form.msg91')</h3>
                <span class="text-2xl font-bold leading-none text-purple-600 sm:text-3xl dark:text-purple-400">{{ $msg91TotalCount }}</span>
                <p class="flex items-center text-base font-normal text-gray-500 dark:text-gray-400">
                    <span class="flex items-center mr-1.5 text-sm text-purple-500 dark:text-purple-400">
                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                            <path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"></path>
                            <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"></path>
                        </svg>
                    </span>
                    @lang('sms::modules.sms.totalSmsSentViaMsg91')
                </p>
            </div>
        </div>
    </div>

    <!-- Important Information Alert -->
    <div class="mb-6 mt-6">
        <x-alert type="warning">
            <div class="flex items-start">
                <svg class="w-5 h-5 text-yellow-600 dark:text-yellow-400 mr-3 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                </svg>
                <div class="flex-1">
                    <h5 class="font-semibold text-yellow-800 dark:text-yellow-200 mb-2">{{ __('sms::modules.alerts.importantSmsGatewayInformation') }}</h5>
                    <ul class="list-disc pl-5 space-y-2 text-yellow-700 dark:text-yellow-300">
                        <li><strong>{{ __('sms::modules.alerts.singleGatewayOnly') }}</strong> - {{ __('sms::modules.alerts.singleGatewayDescription') }}</li>
                        <li>{{ __('sms::modules.alerts.mobileNumberFormat') }}</li>
                        <li>{{ __('sms::modules.alerts.smsCountLimitation') }}</li>
                    </ul>
                </div>
            </div>
        </x-alert>
    </div>

    <form wire:submit.prevent="submitForm">
        <!-- SMS Gateway Selection -->
        <div class="mb-8">
            <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
                <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">{{ __('sms::modules.form.selectSmsGateway') }}</h3>
                <p class="text-sm text-gray-600 dark:text-gray-400 mb-6">{{ __('sms::modules.form.onlyOneGatewayCanBeActive') }}</p>

                <!-- Gateway Selection Cards -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <!-- Vonage Card -->
                    <div class="relative border-2 rounded-lg p-4 transition-all duration-200 {{ $vonage_status ? 'border-blue-500 bg-blue-50 dark:bg-blue-900/20' : 'border-gray-200 dark:border-gray-600 hover:border-gray-300 dark:hover:border-gray-500' }}">
                        <div class="flex items-center justify-between">
                            <div class="flex items-center">
                                <svg class="w-8 h-8 mr-4 text-gray-700 dark:text-gray-300" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-label="Vonage" fill="currentColor">
                                    <path d="M9.279 11.617l-4.54-10.07H0l6.797 15.296a.084.084 0 0 0 .153 0zm9.898-10.07s-6.148 13.868-6.917 15.565c-1.838 4.056-3.2 5.07-4.588 5.289a.026.026 0 0 0 .004.052h4.34c1.911 0 3.219-1.285 5.06-5.341C17.72 15.694 24 1.547 24 1.547z"/>
                                </svg>
                                <div>
                                    <h4 class="text-lg font-semibold text-gray-900 dark:text-white">{{ __('sms::modules.form.vonage') }}</h4>
                                    <p class="text-sm text-gray-600 dark:text-gray-400">{{ __('sms::modules.form.nexmoIsNowVonage') }}</p>
                                </div>
                            </div>
                            <div class="flex items-center">
                                <x-checkbox id="vonage_status" wire:model.live="vonage_status" />
                                <x-label for="vonage_status" class="ml-2" value="{{ __('sms::modules.form.enable') }}" />
                            </div>
                        </div>
                        @if($vonage_status)
                        <div class="mt-4 p-3 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-lg">
                            <div class="flex items-center">
                                <svg class="w-4 h-4 text-green-600 dark:text-green-400 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span class="text-sm text-green-700 dark:text-green-300 font-medium">{{ __('sms::modules.form.activeGateway') }}</span>
                            </div>
                        </div>
                        @endif
                    </div>

                    <!-- MSG91 Card -->
                    <div class="relative border-2 rounded-lg p-4 transition-all duration-200 {{ $msg91_status ? 'border-blue-500 bg-blue-50 dark:bg-blue-900/20' : 'border-gray-200 dark:border-gray-600 hover:border-gray-300 dark:hover:border-gray-500' }}">
                        <div class="flex items-center justify-between">
                            <div class="flex items-center">
                                <svg class="w-16 h-16" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 250 80" role="img" aria-label="MSG91">
                                    <path d="M10 10 L70 0 L70 60 L10 60 Z" fill="#2196F3"/>
                                    <path d="M20 30 L35 40 L60 15" fill="none" stroke="#fff" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
                                    <text x="85" y="45" font-family="Arial, Helvetica, sans-serif" font-size="32" font-weight="400" fill="#444">MSG</text>
                                    <text x="170" y="45" font-family="Arial, Helvetica, sans-serif" font-size="32" font-weight="400" fill="#2196F3">91</text>
                                </svg>
                                <div>
                                    <h4 class="text-lg font-semibold text-gray-900 dark:text-white">{{ __('sms::modules.form.msg91') }}</h4>
                                    <p class="text-sm text-gray-600 dark:text-gray-400">{{ __('sms::modules.form.msg91Description') }}</p>
                                </div>
                            </div>
                            <div class="flex items-center">
                                <x-checkbox id="msg91_status" wire:model.live="msg91_status" />
                                <x-label for="msg91_status" class="ml-2" value="{{ __('sms::modules.form.enable') }}" />
                            </div>
                        </div>
                        @if($msg91_status)
                        <div class="mt-4 p-3 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-lg">
                            <div class="flex items-center">
                                <svg class="w-4 h-4 text-green-600 dark:text-green-400 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                <span class="text-sm text-green-700 dark:text-green-300 font-medium">{{ __('sms::modules.form.activeGateway') }}</span>
                            </div>
                        </div>
                        @endif
                    </div>
                </div>
            </div>
        </div>

        <!-- Vonage Configuration Section -->
        @if($vonage_status)
        <div class="mb-8">
            <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
                <div class="flex items-center mb-6">
                    <svg class="w-8 h-8 mr-4 text-gray-700 dark:text-gray-300" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-label="Vonage" fill="currentColor">
                        <path d="M9.279 11.617l-4.54-10.07H0l6.797 15.296a.084.084 0 0 0 .153 0zm9.898-10.07s-6.148 13.868-6.917 15.565c-1.838 4.056-3.2 5.07-4.588 5.289a.026.026 0 0 0 .004.052h4.34c1.911 0 3.219-1.285 5.06-5.341C17.72 15.694 24 1.547 24 1.547z"/>
                    </svg>
                    <div>
                        <h3 class="text-xl font-bold text-gray-900 dark:text-white">{{ __('sms::modules.form.vonageConfiguration') }}</h3>
                        <p class="text-sm text-gray-600 dark:text-gray-400">{{ __('sms::modules.form.configureVonageSettings') }}</p>
                    </div>
                </div>

                <div class="space-y-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <x-label for="vonage_api_key" value="{{ __('sms::modules.form.apiKey') }}" required="true"/>
                            <x-input-password id="vonage_api_key" wire:model="vonage_api_key" class="block mt-1 w-full" placeholder="{{ __('sms::placeholders.enterVonageApiKey') }}"/>
                            <x-input-error for="vonage_api_key" class="mt-2" />
                        </div>

                        <div>
                            <x-label for="vonage_api_secret" value="{{ __('sms::modules.form.authToken') }}" required="true"/>
                            <x-input-password id="vonage_api_secret" wire:model="vonage_api_secret" class="block mt-1 w-full" placeholder="{{ __('sms::placeholders.enterVonageAuthToken') }}"/>
                            <x-input-error for="vonage_api_secret" class="mt-2" />
                        </div>
                    </div>

                    <div>
                        <x-label for="vonage_from_number" value="{{ __('sms::modules.form.smsFrom') }}" required="true"/>
                        <x-input id="vonage_from_number" wire:model="vonage_from_number" class="block mt-1 w-full" type="tel" placeholder="{{ __('sms::placeholders.phoneNumberExample') }}"/>
                        <x-input-error for="vonage_from_number" class="mt-2" />
                    </div>
                </div>
            </div>
        </div>
        @endif

        <!-- MSG91 Configuration Section -->
        @if($msg91_status)
        <div class="mb-8">
            <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
                <div class="flex items-center mb-6">
                    <svg class="w-16 h-16" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 250 80" role="img" aria-label="MSG91">
                        <path d="M10 10 L70 0 L70 60 L10 60 Z" fill="#2196F3"/>
                        <path d="M20 30 L35 40 L60 15" fill="none" stroke="#fff" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
                        <text x="85" y="45" font-family="Arial, Helvetica, sans-serif" font-size="32" font-weight="400" fill="#444">MSG</text>
                        <text x="170" y="45" font-family="Arial, Helvetica, sans-serif" font-size="32" font-weight="400" fill="#2196F3">91</text>
                    </svg>
                    <div>
                        <h3 class="text-xl font-bold text-gray-900 dark:text-white">{{ __('sms::modules.form.msg91Configuration') }}</h3>
                        <p class="text-sm text-gray-600 dark:text-gray-400">{{ __('sms::modules.form.configureMsg91Settings') }}</p>
                    </div>
                </div>

                <div class="space-y-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <x-label for="msg91_auth_key" value="{{ __('sms::modules.form.authKey') }}" required="true"/>
                            <x-input-password id="msg91_auth_key" wire:model="msg91_auth_key" class="block mt-1 w-full" placeholder="{{ __('sms::placeholders.enterMsg91AuthKey') }}"/>
                            <x-input-error for="msg91_auth_key" class="mt-2" />
                        </div>

                        <div>
                            <x-label for="msg91_from" value="{{ __('sms::modules.form.senderId') }}" required="true"/>
                            <x-input id="msg91_from" wire:model="msg91_from" class="block mt-1 w-full" type="text" placeholder="{{ __('sms::placeholders.enterSenderId') }}"/>
                            <x-input-error for="msg91_from" class="mt-2" />
                        </div>
                    </div>
                    
                    <!-- Flow ID Configuration -->
                    <div class="mt-8">
                        <h4 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">{{ __('sms::modules.form.flowIdConfiguration') }}</h4>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <x-label for="reservation_confirmed_flow_id" value="{{ __('sms::modules.form.reservationConfirmedFlowId') }}" required="true"/>
                                <x-input id="reservation_confirmed_flow_id" wire:model="reservation_confirmed_flow_id" class="block mt-1 w-full" type="text" placeholder="{{ __('sms::placeholders.enterFlowId') }}"/>
                                <x-input-error for="reservation_confirmed_flow_id" class="mt-2" />

                                <!-- Reservation Message Block -->
                                <div class="mt-3 p-4 bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg">
                                    <div class="flex items-center justify-between">
                                        <div class="flex-1">
                                            <p class="text-sm text-blue-700 dark:text-blue-300 font-mono bg-white dark:bg-gray-800 p-2 rounded border">
                                                Hello ##customer_name##, your reservation is confirmed at ##restaurant_name##. Reservation Date & Time: ##reservation_date_time##. Thank you!
                                            </p>
                                        </div>
                                        <button type="button"
                                                onclick="copyToClipboard('Hello ##customer_name##, your reservation is confirmed at ##restaurant_name##. Reservation Date & Time: ##reservation_date_time##. Thank you!')"
                                                class="ml-3 p-2 text-blue-600 dark:text-blue-400 hover:text-blue-800 dark:hover:text-blue-200 hover:bg-blue-100 dark:hover:bg-blue-800/30 rounded-lg transition-colors duration-200"
                                                title="Copy to clipboard">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div>
                                <x-label for="order_bill_sent_flow_id" value="{{ __('sms::modules.form.orderBillSentFlowId') }}" required="true"/>
                                <x-input id="order_bill_sent_flow_id" wire:model="order_bill_sent_flow_id" class="block mt-1 w-full" type="text" placeholder="{{ __('sms::placeholders.enterFlowId') }}"/>
                                <x-input-error for="order_bill_sent_flow_id" class="mt-2" />

                                <!-- Order Bill Message Block -->
                                <div class="mt-3 p-4 bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg">
                                    <div class="flex items-center justify-between">
                                        <div class="flex-1">
                                            <p class="text-sm text-blue-700 dark:text-blue-300 font-mono bg-white dark:bg-gray-800 p-2 rounded border">
                                                Hello ##customer_name##, Thank you for dining with us at ##restaurant_name##! It was our pleasure to serve you!. Order: ##order_number##. Total: ##order_total##. Thank you!
                                            </p>
                                        </div>
                                        <button type="button"
                                                onclick="copyToClipboard('Hello ##customer_name##, Thank you for dining with us at ##restaurant_name##! It was our pleasure to serve you!. Order: ##order_number##. Total: ##order_total##. Thank you!')"
                                                class="ml-3 p-2 text-blue-600 dark:text-blue-400 hover:text-blue-800 dark:hover:text-blue-200 hover:bg-blue-100 dark:hover:bg-blue-800/30 rounded-lg transition-colors duration-200"
                                                title="Copy to clipboard">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div>
                                <x-label for="send_otp_flow_id" value="{{ __('sms::modules.form.sendOtpFlowId') }}" required="true"/>
                                <x-input id="send_otp_flow_id" wire:model="send_otp_flow_id" class="block mt-1 w-full" type="text" placeholder="{{ __('sms::placeholders.enterFlowId') }}"/>
                                <x-input-error for="send_otp_flow_id" class="mt-2" />

                                <!-- OTP Message Block -->
                                <div class="mt-3 p-4 bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg">
                                    <div class="flex items-center justify-between">
                                        <div class="flex-1">
                                            <p class="text-sm text-blue-700 dark:text-blue-300 font-mono bg-white dark:bg-gray-800 p-2 rounded border">
                                                ##var## is the OTP to access your account. Do not share it with anyone.
                                            </p>
                                        </div>
                                        <button type="button"
                                                onclick="copyToClipboard('##var## is the OTP to access your account. Do not share it with anyone.')"
                                                class="ml-3 p-2 text-blue-600 dark:text-blue-400 hover:text-blue-800 dark:hover:text-blue-200 hover:bg-blue-100 dark:hover:bg-blue-800/30 rounded-lg transition-colors duration-200"
                                                title="Copy to clipboard">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div>
                                <x-label for="send_verify_otp_flow_id" value="{{ __('sms::modules.form.sendVerifyOtpFlowId') }}" required="true"/>
                                <x-input id="send_verify_otp_flow_id" wire:model="send_verify_otp_flow_id" class="block mt-1 w-full" type="text" placeholder="{{ __('sms::placeholders.enterFlowId') }}"/>
                                <x-input-error for="send_verify_otp_flow_id" class="mt-2" />

                                <!-- Verify OTP Message Block -->
                                <div class="mt-3 p-4 bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg">
                                    <div class="flex items-center justify-between">
                                        <div class="flex-1">
                                            <p class="text-sm text-blue-700 dark:text-blue-300 font-mono bg-white dark:bg-gray-800 p-2 rounded border">
                                                ##var## is the OTP to verify your phone number. Do not share it with anyone.
                                            </p>
                                        </div>
                                        <button type="button"
                                                onclick="copyToClipboard('##var## is the OTP to verify your phone number. Do not share it with anyone.')"
                                                class="ml-3 p-2 text-blue-600 dark:text-blue-400 hover:text-blue-800 dark:hover:text-blue-200 hover:bg-blue-100 dark:hover:bg-blue-800/30 rounded-lg transition-colors duration-200"
                                                title="Copy to clipboard">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        @endif

        <!-- Phone Verification Section -->
        <div class="mb-8">
            <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
                <div class="flex items-center justify-between mb-6">
                    <div class="flex items-center">
                        <svg class="w-8 h-8 mr-4 text-gray-700 dark:text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                        </svg>
                        <div>
                            <h3 class="text-xl font-bold text-gray-900 dark:text-white">
                                {{ __('sms::modules.form.phoneVerification') }}
                            </h3>
                            <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">
                                {{ __('sms::modules.form.enablePhoneVerificationDescription') }}
                            </p>
                        </div>
                    </div>
                    <div class="flex items-center">
                        <x-checkbox id="phone_verification_status" wire:model.live="phone_verification_status" />
                        <x-label for="phone_verification_status" class="ml-2" value="{{ __('sms::modules.form.enablePhoneVerification') }}" />
                    </div>
                </div>

                @if($phone_verification_status)
                <div class="flex items-center p-4 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-lg">
                    <svg class="w-5 h-5 text-green-600 dark:text-green-400 mr-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                    </svg>
                    <div>
                        <h4 class="text-sm font-medium text-green-800 dark:text-green-200">
                            {{ __('sms::modules.form.phoneVerificationEnabled') }}
                        </h4>
                        <p class="text-sm text-green-700 dark:text-green-300 mt-1">
                            {{ __('sms::modules.form.phoneVerificationEnabledDescription') }}
                        </p>
                    </div>
                </div>
                @endif
            </div>
        </div>

        <div class="flex items-center justify-end mt-8 space-x-2 pt-4 border-t border-gray-200 dark:border-gray-700">
            {{-- <x-secondary-button type="button" wire:click="$set('showTestMessageModal', true)">
                {{ __('sms::modules.form.sendTestMessage') }}
            </x-secondary-button> --}}
            <x-button>@lang('app.save')</x-button>
        </div>
    </form>

    <x-dialog-modal wire:model.live="showTestMessageModal">
        <x-slot name="title">
            {{ __('sms::modules.form.sendTestMessage') }}
        </x-slot>
        <x-slot name="content">
            <div>
                <x-label for="customerPhone" value="{{ __('modules.customer.phone') }}" />
                <div class="flex gap-2 mt-2">
                    <!-- Phone Code Dropdown -->
                    <div x-data="{ isOpen: @entangle('phoneCodeIsOpen').live }" @click.away="isOpen = false" class="relative w-32">
                        <div @click="isOpen = !isOpen"
                            class="p-2 bg-gray-100 border rounded cursor-pointer dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 dark:focus:border-gray-600 dark:focus:ring-gray-600">
                            <div class="flex items-center justify-between">
                                <span class="text-sm">
                                    @if($phoneCode)
                                        +{{ $phoneCode }}
                                    @else
                                        {{ __('modules.settings.select') }}
                                    @endif
                                </span>
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </div>
                        </div>

                        <!-- Search Input and Options -->
                        <ul x-show="isOpen" x-transition class="absolute z-10 w-full mt-1 overflow-auto bg-white rounded-lg shadow-lg max-h-60 ring-1 ring-black ring-opacity-5 focus:outline-none sm:text-sm dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 dark:focus:border-gray-600 dark:focus:ring-gray-600">
                            <li class="sticky top-0 px-3 py-2 bg-white dark:bg-gray-900 z-10">
                                <x-input wire:model.live.debounce.300ms="phoneCodeSearch" class="block w-full" type="text" placeholder="{{ __('placeholders.search') }}" />
                            </li>
                            @forelse ($phonecodes ?? [] as $phonecode)
                                <li @click="$wire.selectPhoneCode('{{ $phonecode }}')"
                                    wire:key="phone-code-{{ $phonecode }}"
                                    class="relative py-2 pl-3 text-gray-900 transition-colors duration-150 cursor-pointer select-none pr-9 hover:bg-gray-100 dark:border-gray-700 dark:hover:bg-gray-800 dark:text-gray-300 dark:focus:border-gray-600 dark:focus:ring-gray-600"
                                    :class="{ 'bg-gray-100 dark:bg-gray-800': '{{ $phonecode }}' === '{{ $phoneCode }}' }" role="option">
                                    <div class="flex items-center">
                                        <span class="block ml-3 text-sm whitespace-nowrap">+{{ $phonecode }}</span>
                                        <span x-show="'{{ $phonecode }}' === '{{ $phoneCode }}'" class="absolute inset-y-0 right-0 flex items-center pr-4 text-black dark:text-gray-300" x-cloak>
                                            <svg class="w-5 h-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                                <path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 0 1 .143 1.052l-8 10.5a.75.75 0 0 1-1.127.075l-4.5-4.5a.75.75 0 0 1 1.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 0 1 1.05-.143Z" clip-rule="evenodd" />
                                            </svg>
                                        </span>
                                    </div>
                                </li>
                            @empty
                                <li class="relative py-2 pl-3 text-gray-500 cursor-default select-none pr-9 dark:text-gray-400">
                                    {{ __('modules.settings.noPhoneCodesFound') }}
                                </li>
                            @endforelse
                        </ul>
                    </div>

                    <!-- Phone Number Input -->
                    <x-input id="customerPhone" class="block w-full" type="tel" wire:model='phone' required />
                </div>
                <x-input-error for="phoneCode" class="mt-2" />
                <x-input-error for="phone" class="mt-2" />
            </div>
        </x-slot>
        <x-slot name="footer">
            <x-secondary-button wire:click="$set('showTestMessageModal', false)">
                {{ __('app.cancel') }}
            </x-secondary-button>

            <x-button class="ml-2" wire:click="sendTestMessage" wire:loading.attr="disabled">
                <span wire:loading.remove>{{ __('sms::modules.form.sendTestMessage') }}</span>
                <span wire:loading>{{ __('sms::modules.messages.sending') }}</span>
            </x-button>
        </x-slot>
    </x-dialog-modal>
</div>

<script>
function copyToClipboard(text) {
    const button = event.target.closest('button');
    const originalHTML = button.innerHTML;

    navigator.clipboard.writeText(text).then(function() {
        // Show "Copied" text like in cron message file
        button.innerHTML = `Copied`;

        setTimeout(() => {
            button.innerHTML = originalHTML;
        }, 2000);
    }).catch(function(err) {
        console.error('Could not copy text: ', err);

        // Fallback for older browsers
        const textArea = document.createElement('textarea');
        textArea.value = text;
        document.body.appendChild(textArea);
        textArea.select();
        try {
            document.execCommand('copy');
            textArea.remove();
            // Show "Copied" for fallback too
            button.innerHTML = `Copied`;
            setTimeout(() => {
                button.innerHTML = originalHTML;
            }, 2000);
        } catch (err) {
            console.error('Failed to copy text:', err);
            // Show error state
            button.innerHTML = `Failed`;
            setTimeout(() => {
                button.innerHTML = originalHTML;
            }, 2000);
        }
    });
}
</script>
