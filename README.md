## README

It's a simple true or false game.

The basic thing on these game is that your mind is the compiler.

You need to compile and answer true or false for each expression/code you
challenge!

## How to add new challenges

Wow! Contribute with new challenges by adding new files on [app/challenges](/app/challenges) directory.

For a while it's a simple and basic ruby files and nested lines should be identified by a challenge.

It uses eval to load, so, if you create a variable, it will be visible in all challenges!

    == ATTENTION ==
    Be careful because it's using the same environment the application 
    and not uses an isolated sandbox to compile each challenge result separately.
    ==

## Loading challenges

Use rake task to load challenges:

    rake load_game

Or upload it on the cloud:

    heroku run rake load_game

## Setup project

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
