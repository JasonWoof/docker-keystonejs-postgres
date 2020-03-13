# Experimenting with Docker and KeystoneJS

This project was to try docker-compose more seriously, and try KeystoneJS.

# Status

Status: Working, except a bug in KeystoneJS requires a workaround after your starter code is created.

# How To Run It

Install docker-compose

Run `./main && ./main logs`

Name it whatever you like

Choose "Starter (Users + Authentication)"

Choose the "Knex" database adapter when it asks.

Press control-C when you're done looking at logs (this doesn't stop the virtual machines, just the log viewer)

To stop it: `./main stop`

To remove the (tiny) image for for running postgres as your user run: `./main destroy`

If this bug hasn't been fixed yet: https://github.com/keystonejs/keystone/issues/2159 then you'll get errors, and need to do this workaround: replace `new Adapter()` with `new Adapter({dropDatabase:true})` in `./keystone/app/index.js` then restart the runner with `./main stop; ./main && ./main logs` then revert your change to `./keystone/app/index.js` (if you don't revert the change, then it'll delete all the data in the database every time you run it.

Run `./main logs` to see errors, URLs, and your default username/password for admin functionality

Edit keystone/app/index.js to only allow admins to change Users.isAdmin.
