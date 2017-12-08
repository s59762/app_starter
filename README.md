# README

This is a rails application starter-kit @odd.

## How to use

1. clone this repo.
2. `cp -r app_starter YOUR_PROJECT_NAME` and goto project path.
3. exec `bin/setup` in terminal for setting up application.
4. global search for `RENAME:`, change name for your project instead of `AppStarter` or `app_starter_`
5. `bin/server` to start services.
6. using `rails s` for development server.

After all, go to `http://localhost:3000` and start coding!

### Suggestion

You can use [rails-dashboard](https://www.npmjs.com/package/rails-dashboard) for booting up rails server. But be careful rails server maybe shutdown randomlly after update application config or `Gemfile`.

### Warning!

`bin/setup` should **ONLY** execute at very first time. This script will remove git history and re-init for project.

## Extra functions

### Remote pry

Using `binding.remote_pry` to set breakpoint in your program, and use `pry-remote` in terminal to debug.

### Yard server

`bin/server` will also booting up **yard server** for writing documentation, you can access `http://localhost:8808` in browser for check _current_ documentation.

Documentation will output to `docs/`, and we can let Github Pages host our documentation page.

For example:

https://oracle-design.github.io/app_starter/

> With this functionality, you almost have no excuse not to write documentation!
>
> -- https://yardoc.org/

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
