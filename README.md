# README

This is a rails application starter-kit @odd.

## How to use

1.  clone this repo.
2.  `cp -r app_starter YOUR_PROJECT_NAME` and goto project path.
3.  exec `bin/setup` in terminal for setting up application.
4.  global search for `RENAME:`, change name for your project instead of `AppStarter` or `app_starter_`
5.  `bin/server` to start services.
6.  using `rails s` for development server.

After all, go to `http://localhost:3000` and start coding!

### Requirement

We using [overmind](https://github.com/DarthSim/overmind) instead of foreman for booting up services that defined in Procfile. Please check if `overmind` are installed in your system before using `bin/server` script.

### Warning!

`bin/setup` should **ONLY** execute at very first time. This script will remove git history and re-init for project.

## Extra features

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

### Mailcatcher

You have to install `mailcatcher` gem in your development env first, just exec `gem install mailcatcher`. Than you can boot up mail service with command `mailcatcher` in terminal.

Visit `http://localhost:1080/` you will get a web mail interface, and all emails that send from application will list in here. Using Mailcatcher is easy for development and debugging more than ever.

### EspressoMartini

This gem is build for generate general file templates in our daily development life. Repo [here](https://github.com/oracle-design/espresso_martini).
