#!/bin/bash

cd /work/site

HOME=/work composer dumpautoload --optimize
php artisan config:cache
php artisan route:cache