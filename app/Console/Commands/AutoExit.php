<?php

namespace App\Console\Commands;

use App\Log;
use Carbon\Carbon;
use Illuminate\Console\Command;

class AutoExit extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'auto:exit';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'End all open log entries.';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $qLogs = Log::whereNull('exited_at');
        $count = $qLogs->count();
        if(!$count) {
            $this->info('No entries without exit time found.');
            return ;
        }
        if(!$this->confirm('Set randomized auto-exit for ' . $count . ' entries?')) {
            return;
        }
        $logs = $qLogs->get();
        foreach ($logs as $log) {
            $time = new Carbon($log->created_at);
            $time = $time->hours(17)->minutes(20)->seconds(0);
            $log->exited_at = $time->addSeconds(rand(5, 1800));
            $this->info("[$log->id] $log->created_at => $log->exited_at");
            $log->save();
        }
        return 0;
    }
}
