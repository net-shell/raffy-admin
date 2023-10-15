# NetShell Raffy

RFID-enabled authentication, authorization and time tracking for company propery access control.

<img src="https://i.ibb.co/w4PZqKg/Screenshot-2022-01-23-at-0-09-48.png">
<img src="https://i.ibb.co/m09W7Z8/Screenshot-2022-01-23-at-0-12-02.png">

## 1. Prerequisites

### 1.1. Install Composer (Windows)

[Composer-Setup.exe](https://getcomposer.org/Composer-Setup.exe)

### 1.2. Install Docker Compose (Windows)

#### 1.2.1. [Download Docker Desktop for Windows.](https://docs.docker.com/desktop/windows/wsl/).

#### 1.2.2. Follow the usual installation instructions to install Docker Desktop. If you are running a supported system, Docker Desktop prompts you to enable WSL 2 during installation. Read the information displayed on the screen and enable WSL 2 to continue.

#### 1.2.3. Start Docker Desktop from the Windows Start menu.

#### 1.2.4. From the Docker menu, select Settings and then General.

#### 1.2.5. Select the Use WSL 2 based engine check box.

## 2. Project Setup

### 2.1. Clone the project
```
git clone https://github.com/net-shell/raffy-admin.git
cd raffy-admin
```

### 2.2. Start Docker services

#### 2.2.1. Shell in the PHP container
```
docker exec -it raffy-web-1 /bin/bash
```
Later, press `Ctrl+D` to exit the container shell.

#### 2.2.2. Install dependencies
```
composer install
composer run-script install-tasks
php artisan storage:link
```
#### 2.2.3. In [WSL2 terminal](https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-10#1-overview) run this command:

```
./vendor/bin/sail up -d
```

#### 2.2.4. Shell in the Echo container
```
docker exec -it raffy-echo-1 /bin/sh;
```

#### 2.2.5. Build assets
```
export NODE_OPTIONS=--openssl-legacy-provider
npm install
npm run prod
```
*Alternatively, you could build assets for development (`npm run dev`) or watch for changes to source, which can be useful when actively modifying them (`npm run watch`). However, production assets are more secure, load faster and are very optimized.*

## 3. Configuration

#### 3.1. Shell in the PHP container
```
docker exec -it raffy-php-1 /bin/sh;
```

#### 3.2. Run the migrations
```
php artisan voyager:install
```

#### 3.3. Import Voyager configuration
```
php artisan voyager:import
```

### 4. Test in browser!

Go to [http://raffy.local](http://raffy.local) in your web browser.

You should see the login screen. Use the account created in step 3.4.

## 5. Usage

#### 5.1. Create admin user
```
php artisan voyager:admin --create
```

### 5.2 Import users from CSV
```
php artisan import:workers {csv}
```
