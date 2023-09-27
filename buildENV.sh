#!/usr/bin/env bash

# 建立 .env 文件
if [ ! -f .env ]; then
    cp .env.example .env
    file=".env"
fi
php artisan key:generate

# 目前的 APP_KEY
current_app_key=$(grep -i 'APP_KEY=' .env | cut -d '=' -f2)

composer install

# 檢查 APP_KEY 是否為空
if [ -z "$current_app_key" ]; then
    # 生成應用程式金鑰
    php artisan key:generate
fi

if [ ! -d public/storage ]
then
    php artisan storage:link
fi

echo 'Environment build finish!';
