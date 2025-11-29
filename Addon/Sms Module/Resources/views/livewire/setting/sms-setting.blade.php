<div class="p-4 bg-white block dark:bg-gray-800 dark:border-gray-700">
    <div class="mb-6">
        <h3 class="text-2xl font-bold text-gray-900 dark:text-white">{{ __('sms::modules.menu.smsSettings') }}</h3>
    </div>

    <!-- SMS Usage Widgets Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">

        <!-- Widget 1: SMS Status -->
        <div class="items-center justify-between p-4 bg-white border border-gray-200 rounded-lg shadow-sm sm:flex dark:border-gray-700 sm:p-6 dark:bg-gray-800">
            <div class="w-full">
                <div class="flex items-center justify-between mb-2">
                    <h3 class="text-base font-normal text-gray-500 dark:text-gray-400">@lang('sms::modules.package.packageLimit')</h3>
                    @if($packageSmsCount == -1)
                        <span class="bg-green-100 uppercase text-green-800 text-xs font-medium px-2.5 py-0.5 rounded dark:bg-green-900 dark:text-green-300">
                            @lang('sms::modules.package.unlimited')
                        </span>
                    @else
                        @if($isSmsLimitReached)
                            <span class="bg-red-100 uppercase text-red-800 text-xs font-medium px-2.5 py-0.5 rounded dark:bg-red-900 dark:text-red-300">
                                @lang('sms::modules.package.exhausted')
                            </span>
                        @else
                            <span class="bg-blue-100 uppercase text-blue-800 text-xs font-medium px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300">
                                @lang('sms::modules.package.active')
                            </span>
                        @endif
                    @endif
                </div>
                @if($packageSmsCount == -1)
                    <span class="text-2xl font-bold leading-none text-gray-900 sm:text-3xl dark:text-white">∞</span>
                    <p class="flex items-center text-base font-normal text-gray-500 dark:text-gray-400">
                        <span class="flex items-center mr-1.5 text-sm text-gray-500 dark:text-gray-400">
                            @lang('sms::modules.package.unlimitedMessagesAllowed')
                        </span>
                    </p>
                @else
                    <span class="text-2xl font-bold leading-none text-gray-900 sm:text-3xl dark:text-white">{{ $packageSmsCount }}</span>
                    <p class="flex items-center text-base font-normal text-gray-500 dark:text-gray-400">
                        <span class="flex items-center mr-1.5 text-sm text-gray-500 dark:text-gray-400">
                            @lang('sms::modules.package.totalSmsInPackage')
                        </span>
                    </p>
                @endif
            </div>
        </div>

        <!-- Widget 2: Used SMS Count -->
        <div class="items-center justify-between p-4 bg-white border border-gray-200 rounded-lg shadow-sm sm:flex dark:border-gray-700 sm:p-6 dark:bg-gray-800">
            <div class="w-full">
                <h3 class="text-base font-normal text-gray-500 dark:text-gray-400">{{ __('sms::modules.package.usedSmsCount') }}</h3>
                <span class="text-2xl font-bold leading-none text-gray-900 sm:text-3xl dark:text-white">{{ $usedSmsCount }}</span>
                <p class="flex items-center text-base font-normal text-gray-500 dark:text-gray-400">
                    @if($packageSmsCount != -1)
                        @php
                            $usagePercent = $packageSmsCount > 0 ? round(($usedSmsCount / $packageSmsCount) * 100, 1) : 0;
                        @endphp
                        <span class="flex items-center mr-1.5 text-sm {{ $usagePercent > 80 ? 'text-red-500 dark:text-red-400' : 'text-blue-500 dark:text-blue-400' }}">
                            <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                @if($usagePercent > 80)
                                    <path clip-rule="evenodd" fill-rule="evenodd" d="M10 3a.75.75 0 01.75.75v10.638l3.96-4.158a.75.75 0 111.08 1.04l-5.25 5.5a.75.75 0 01-1.08 0l-5.25-5.5a.75.75 0 111.08-1.04l3.96 4.158V3.75A.75.75 0 0110 3z"></path>
                                @else
                                    <path clip-rule="evenodd" fill-rule="evenodd" d="M10 17a.75.75 0 01-.75-.75V5.612L5.29 9.77a.75.75 0 01-1.08-1.04l5.25-5.5a.75.75 0 011.08 0l5.25 5.5a.75.75 0 11-1.08 1.04l-3.96-4.158V16.25A.75.75 0 0110 17z"></path>
                                @endif
                            </svg>
                            {{ $usagePercent }}%
                        </span>
                        {{ __('sms::modules.package.ofPackageUsed') }}

                    @endif
                </p>
            </div>
        </div>
    </div>

    <!-- Important Information Widget -->
    <div class="mb-6">
        <x-alert type="info" class="mb-0">
            {{ __('sms::modules.alerts.mobileNumberFormat') }}
        </x-alert>
    </div>

    <!-- SMS Settings Form -->
    <div class="grid grid-cols-1">
        <form wire:submit="submitForm" class="space-y-6">
            <div class="p-4 mb-4 bg-white border border-gray-200 rounded-lg shadow-sm dark:border-gray-700 sm:p-6 dark:bg-gray-800 xl:mb-0">
                <div class="flow-root">
                    <div class="divide-y divide-gray-200 dark:divide-gray-700">
                        @foreach ($notificationSettings as $key => $item)
                        <div class="flex items-center justify-between py-4">
                            <div class="flex flex-col flex-grow">
                                <div class="flex items-center">
                                    <div class="text-lg font-semibold text-gray-900 dark:text-white">@lang('sms::modules.notifications.' . $item->type)</div>

                                    <!-- SMS Count Badge - Same style as dashboard -->
                                    @if(sms_setting()->vonage_status || sms_setting()->msg91_status)
                                        <span class="inline-flex items-center justify-center px-2 py-0.5 ms-2 text-xs font-semibold text-white bg-skin-base rounded-md">
                                            {{ $smsCounts[$item->type] ?? 0 }}
                                        </span>
                                    @endif
                                </div>

                                <div class="text-base font-normal text-gray-500 dark:text-gray-400">
                                    @lang('sms::modules.notifications.' . $item->type.'_info')
                                </div>
                            </div>

                            <div class="flex items-center gap-3">
                                @if(sms_setting()->vonage_status || sms_setting()->msg91_status)
                                    <button type="button"
                                        class="px-3 py-1 text-sm font-medium text-blue-600 bg-blue-50 border border-blue-200 rounded-md hover:bg-blue-100 dark:bg-blue-900 dark:text-blue-300 dark:border-blue-700 dark:hover:bg-blue-800"
                                        wire:click="openViewModal('{{ $item->type }}')">
                                        {{ __('app.view') }}
                                    </button>
                                @endif

                                <label for="checkbox_{{ $item->type }}" class="relative flex items-center cursor-pointer"
                                    wire:key='send_email_{{ microtime() }}'>
                                    <input type="checkbox" id="checkbox_{{ $item->type }}" @checked($sendEmail[$key])
                                        wire:model.live='sendEmail.{{ $key }}' class="sr-only">
                                    <span
                                        class="h-6 bg-gray-200 border border-gray-200 rounded-full w-11 toggle-bg dark:bg-gray-700 dark:border-gray-600"></span>
                                </label>
                            </div>
                        </div>
                        @endforeach
                    </div>

                    <div class="mt-6">
                        <x-button>@lang('app.save')</x-button>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- View Modal -->
    <x-dialog-modal wire:model.live="showViewModal" maxWidth="md">
        <x-slot name="title">
            @if(!empty($notificationDetails) && isset($notificationDetails['title']))
                {{ $notificationDetails['title'] }}
            @endif
        </x-slot>

        <x-slot name="content">
            @if(!empty($notificationDetails) && isset($notificationDetails['sms_message']))
                <div class="flex items-center justify-between">
                    <div class="flex-1 bg-white dark:bg-gray-800 p-4 rounded-lg border border-blue-200 dark:border-blue-700">
                        <p class="text-sm text-gray-800 dark:text-gray-200 font-mono leading-relaxed">
                            {{ $notificationDetails['sms_message'] }}
                        </p>
                    </div>
                    <button type="button"
                            onclick="copyToClipboard('{{ addslashes($notificationDetails['sms_message']) }}')"
                            class="ml-3 p-2 text-blue-600 dark:text-blue-400 hover:text-blue-800 dark:hover:text-blue-200 hover:bg-blue-100 dark:hover:bg-blue-800/30 rounded-lg transition-colors duration-200"
                            title="Copy to clipboard">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                        </svg>
                    </button>
                </div>
            @else
                <div class="text-center py-8">
                    <p class="text-gray-500 dark:text-gray-400">{{ __('app.noMessageAvailable') }}</p>
                </div>
            @endif
        </x-slot>

        <x-slot name="footer">
            <div class="flex justify-end">
                <x-button wire:click="$toggle('showViewModal')" class="bg-gray-500 hover:bg-gray-600 text-white">
                    {{ __('app.close') }}
                </x-button>
            </div>
        </x-slot>
    </x-dialog-modal>
</div>

<script>
function copyToClipboard(text) {
    const button = event.target.closest('button');
    const originalHTML = button.innerHTML;

    navigator.clipboard.writeText(text).then(function() {
        // Show "Copied" text
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
