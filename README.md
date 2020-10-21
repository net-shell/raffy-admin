# NetShell Raffy

RFID-enabled authentication, authorization and time tracking for company propery access control.

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

## Running

1. Start Docker services
```
DOMAIN=raffy.local docker-compose up -d
```

2. **Test in browser!**

Go to [http://raffy.admin](http://raffy.admin) in your web browser.

You should see the login screen (or maybe an error).
