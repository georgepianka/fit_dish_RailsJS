# Fit Dish
### Share Recipes / Eat Healthy

This is a Rails App made by George Pianka for Flatiron School Final Project Section 3 (Ruby/Rails). The application allows the user to create, store, share, and rate Recipes, while easily generating Grocery Lists from Recipes they add to their Menu of Dishes. Users can recommend Healthy Ingredient Substitutions, Create a Menu of Dishes for the Week, and Like Recipes so other users can Find a New Favorite.
---

## Setting Up

#### 1. Clone
`$ git clone https://github.com/NotoriousCottonball/fit_dish.git`
#### 2. Bundler
`$ bundle install`
#### 3. Database
`$ rails db:setup` | `$ rails db:schema:load` | `$ rails db:seed`
##### *Note: Fit Dish uses Postgres. Please Make Postgres available on your machine by following the instructions at https://www.postgresql.org/download/.*


## Local Deployment

#### 1. HTTP
`$ rails s`
##### *The Standard Rails server boots without SSL in development mode*
##### *Facebook automatically allows http://localhost REDIRECTS in Development Mode so OmniAuth Login will work*
##### *Navigate to http://localhost:3000/ after Setting Up Facebook OmniAuth as per https://github.com/mkdynamic/omniauth-facebook.*
#### 2. HTTPS (SSL)
`$ thin start --ssl`
##### *Create a self-signed certificate and Uncomment `config.force_ssl = true` in application.rb*
##### *-or- Navigate to https://localhost:3000/ and Proceed Past NET::ERR_CERT_AUTHORITY_INVALID*

---

## Built With

* [Ruby on Rails](http://rubyonrails.org) - Web framework
* [OmniAuth](https://github.com/omniauth/omniauth) - Third-Party Login

## Contributing

Bug reports and pull requests are welcome on GitHub at
#### https://github.com/NotoriousCottonball/fit_dish.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
