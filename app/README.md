# README

A collective bargaining agreement database for affiliates of The International Union of Food, Agricultural, Hotel, Restaurant, Catering, Tobacco and Allied Workers' Associations (IUF).


Developed in Ruby on Rails 4.2


## DEVELOPMENT SETUP


`git clone git@github.com:union-software-cooperative/iufcba`

\# update the application config  

`cp config/application.example.yml config/application.yml`

\# Setup AWS buckets for production and development ( or change to local storage in config/initializers/carrierwave.rb )  
\# Configure mailgun ( or change config.action_mailer.delivery_method in config/environments/... )  
\# Generate secret keys for secpubsub and rails application  
\# change the name of the owner union  
\# change the db/seeds.rb file - the first union's short_name must match the owner union name from application.yml  


`bundle install`

`bundle exec rake db:create`

`bundle exec rake db:migrate`

`bundle exec rake db:seed`


## Deploy on heroku

`heroku apps:create my_unique_app_name`

\# you may have to add the heroku remote

`git remote add heroku https://git.heroku.com/iufcba.git`

`figaro heroku:set -e production`

`git push heroku master`

`heroku run rake db:migrate`

`heroku run rake db:seed`

`heroku domains:add www.iufcba.org`

\# restart after seed so owner union works

`heroku restart`

## Testing

Run this before you run your tests for the first time

`rake db:test:prepare`

 \# Run unit tests like this 
 
`bundle exec spring rspec`

\# Run acceptance tests like this

`bundle exec spring cucumber`

\# Please let us know if you find a reliable way to test select2 in all it's permutations. 


## Contributing

We'd love language translations but will look at any pull request.  

In Solidarity