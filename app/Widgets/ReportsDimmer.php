<?php

namespace App\Widgets;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Widgets\BaseDimmer;

class ReportsDimmer extends BaseDimmer
{
    /**
     * The configuration array.
     *
     * @var array
     */
    protected $config = [];

    /**
     * Treat this method as a controller action.
     * Return view() or other content to display.
     */
    public function run()
    {
        $string = trans('voyager::dimmer.report');

        return view('voyager::dimmer', array_merge($this->config, [
            'icon'   => 'voyager-book',
            'title'  => $string,
            'text'   => __('voyager::dimmer.reports_text', ['string' => Str::lower($string)]),
            'button' => [
                'text' => __('voyager::dimmer.reports_link_text'),
                'link' => url('/report'),
            ],
            'image' => voyager_asset('images/widget-backgrounds/02.jpg'),
        ]));
    }

    /**
     * Determine if the widget should be displayed.
     *
     * @return bool
     */
    public function shouldBeDisplayed()
    {
        return Auth::user()->can('browse', new \App\Log());
    }
}
