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
        $logs = Log::whereNull('exited_at')->get();
        foreach ($logs as $log) {
            $log->exited_at = (new Carbon($log->created_at))->format("Y-m-d 23:59:59");
            $this->info("[$log->id] $log->created_at => $log->exited_at");
            $log->save();
        }
        return 0;
    }
}
