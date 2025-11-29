
@if (in_array('Kiosk', restaurant_modules()))
    <li class="me-2">
        <a href="{{ route('settings.index').'?tab=kioskSettings' }}" wire:navigate
        @class(["
        inline-block p-4 border-b-2 rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300",
        'border-transparent' => ($activeSetting != 'kioskSettings'),
        'active border-skin-base dark:text-skin-base dark:border-skin-base text-skin-base' => ($activeSetting == 'kioskSettings')])>@lang('kiosk::modules.settings.kioskSettings')</a>
    </li>
@endif
