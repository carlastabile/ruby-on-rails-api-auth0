# Ruby on Rails API integration with Auth0 

This Ruby on Rails API integrates with Auth0 to build demonstrate how to build secure endpoints. 

## Run with Docker 
### Pre-requisites 
- Docker
- Docker Compose
  
### Run the server
1. `docker-compose build`
2. `docker-compose run app rails db:migrate db:seed`
3. `docker-compose up`


### Run tests 
`docker-compose run -e "RAILS_ENV=test" app bundle exec rspec`

## Run with local installation 

### Pre-requisites
- RVM 
- Ruby 3.1.2 
- Rails 7.0.3
- MySQL

### Run the server  
1. `rails db:create db:migrate db:seed`
2. `rails s -p 3001`

You will be able to access the server in `http://localhost:3001`

### Run tests 
`rspec`