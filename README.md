# NetShell Raffy

RFID-enabled authentication, authorization and time tracking for company propery access control.

<img src="https://i.ibb.co/w4PZqKg/Screenshot-2022-01-23-at-0-09-48.png">
<img src="https://i.ibb.co/m09W7Z8/Screenshot-2022-01-23-at-0-12-02.png">

## Installation

1. Clone Raffy Admin (and then `cd raffy-admin`)
```
git clone https://github.com/net-shell/raffy-admin.git
```

2. Install dependencies
```
composer install
composer run-script install-tasks
```

3. Build assets
```
npm install
npm run prod
```
*Alternatively, you could build assets for development (`npm run dev`) or watch for changes to source, which can be useful when actively modifying them (`npm run watch`). However, production assets are more secure, load faster and are very optimized.*

## Configuration

1. Set Redis authentication for Laravel Echo

Edit `laravel-echo-server.json` and set Redis password.

2. Run the migrations

`php artisan migrate`

3. Import Voyager configuration

`php artisan voyager:import -y`

Note: There is a known issue with recent versions of voyager-config and the import command seems to be missing. You can import the dump.sql if migrations can't be run.

## Running

1. Start Docker services
```
DOMAIN=raffy.local docker-compose up -d
```

2. **Test in browser!**

Go to [http://raffy.local](http://raffy.local) in your web browser.

You should see the login screen (or maybe an error).
