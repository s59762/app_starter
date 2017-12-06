# README

This is a rails application starter-kit @odd.

## How to use

1. clone this repo.
2. `cp -r app_starter YOUR_PROJECT_NAME` and goto project path
3. global search for `TODO:`, change name for your project instead of `AppStarter` or `app_starter_`
4. `yarn install` to install dependency
5. `./bin/server` to start services
6. `rails db:setup` to setup database
7. using `rails s` for development server.

After all, go to `http://localhost:3000` and start coding!

## Extra functions

### Remote pry

Using `binding.remote_pry` to set breakpoint in your program, and use `pry-remote` in terminal to debug.

### EspressoMartini

This gem is build for generate general file templates in our daily development life.

#### Generating locale files for Model

`rails generate martini:locale:model [MODEL] [LANGUAGE]`

example:

`rails g martini:locale:model user zh-TW`

This will generate a template file at path `app/config/locales/models/user/zh-TW.yml`.

#### Generating locale files for Cell

`rails generate martini:locale:cell [CELL] [LANGUAGE]`

example:

`rails g espresso:locale:cell user zh-TW`

This will generate a template file at path  `app/config/locales/cells/user/zh-TW.yml`

### TODO
[ ] update `./bin/setup` script
