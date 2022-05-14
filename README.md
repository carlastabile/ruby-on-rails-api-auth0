# Ruby on Rails API integration with Auth0 

This Ruby on Rails API integrates with Auth0 to build demonstrate how to build secure endpoints. 

## Pre-requisites
- RVM 
- Ruby 3.1.2 
- Rails 7.0.3

## How was this repo built?
1. `rails new . -T --api`
2. `rails generate model Joke category:string content:string`
3. `rails db:create db:migrate db:seed`
4. `rails g controller Jokes index create`