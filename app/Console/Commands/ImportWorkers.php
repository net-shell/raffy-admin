<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\User;
use App\Section;

class ImportWorkers extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'import:workers {csv}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Import the workers from CSV';

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
        $csvFile = $this->argument('csv');
        $csv = array_map('str_getcsv', file($csvFile));
        foreach ($csv as $line) {
            $section = Section::whereName($line[1])->first();
            $user = new User();
            $user->name = $line[0];
            $user->email = $this->emailize($line[0]);
            $user->password = 'nikdim2020';
            if($section) {
                $user->section_id = $section->id;
            }
            $user->save();
        }
        echo count($csv) . ' workers added.';
        return 0;
    }

    private function emailize($name) {
        $email = $this->transliterate($name);
        $email = strtolower($email);
        $parts = explode(' ', $email);
        return "$parts[0].$parts[2]@nikdim.bg";
    }

    private function transliterate($string) {
        $cyr = [
            'а','б','в','г','д','е','ё','ж','з','и','й','к','л','м','н','о','п',
            'р','с','т','у','ф','х','ц','ч','ш','щ','ъ','ы','ь','э','ю','я',
            'А','Б','В','Г','Д','Е','Ё','Ж','З','И','Й','К','Л','М','Н','О','П',
            'Р','С','Т','У','Ф','Х','Ц','Ч','Ш','Щ','Ъ','Ы','Ь','Э','Ю','Я'
        ];
        $lat = [
            'a','b','v','g','d','e','io','zh','z','i','y','k','l','m','n','o','p',
            'r','s','t','u','f','h','ts','ch','sh','sht','a','i','y','e','yu','ya',
            'A','B','V','G','D','E','Io','Zh','Z','I','Y','K','L','M','N','O','P',
            'R','S','T','U','F','H','Ts','Ch','Sh','Sht','A','I','Y','e','Yu','Ya'
        ];
        return str_replace($cyr, $lat, $string);
    }
}
