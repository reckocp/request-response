This folder structure should be suitable for starting a project that uses a database:

* Fork this repo
* Clone this repo
* Create your classes in lib
* [Optional] Create a "Data" module inside of `lib` inside of it place a constant called `USERS` which is equal to the array of all the user hashes
* [Optional] Replace the user hashes with an instance of a user object
* ... ?
* Profit


## Rundown

```
.
├── Gemfile             # Details which gems are required by the project
├── README.md           # This file
├── console.rb          # `ruby console.rb` starts `pry` with models loaded
└── lib                 # Your ruby code (models, etc.) should go here
    └── all.rb          # Require this file to auto-require _all_ `.rb` files in `lib`
```
