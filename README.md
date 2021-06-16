# Little Shop of Rails

## About this Project
[Little Shop of Rails](https://little-shop-of-rails.herokuapp.com/) is a solo project that builds off of a 4-person group project, [Little Esty Shop](https://little-rails-shop.herokuapp.com/). The original group project required our team to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices. In this solo extension, I explore Rails and ActiveRecord further by creating and integrating bulk discounts, which are unique to specific merchants within the app. 

**Timeframe:** 6 days (solo extension), 9 days (Little Esty Shop)

**Check out my app on Heroku:** [Little Shop of Rails](https://little-shop-of-rails.herokuapp.com/)

**Check out the original app here:** [Little Esty Shop](https://little-rails-shop.herokuapp.com/)

## Little Esty Shop Contributors
- Lawrence Whalen  
   [Github](https://github.com/LawrenceWhalen) | [LinkedIn](https://www.linkedin.com/in/lawrence-whalen-15996220a/)
- Aliya Merali  
   [Github](https://github.com/aliyamerali) | [LinkedIn](https://www.linkedin.com/in/aliyamerali/)
- Molly Krumholz
   [Github](https://github.com/mkrumholz) | [LinkedIn](https://www.linkedin.com/in/mkrumholz/)
- Sidarth Bagawandoss  
   [Github](https://github.com/Sidarth20) | [LinkedIn](https://www.linkedin.com/in/sidarth-bagawandoss-12220644/)

## Learning Goals
 - Practice designing a normalized database schema and defining model relationships
 - Utilize advanced routing techniques including namespacing to organize and group like functionality together
 - Utilize advanced active record techniques to perform complex database queries
 - Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Schema
![Little Esty Shop Schema](https://user-images.githubusercontent.com/5446926/121439757-c7fa6600-c943-11eb-91d2-42a47a418383.png)

## Built With
- Ruby 2.7.2
- Rails 5.2.6
- ActiveRecord
- SQL
- RSpec
- Capybara
- Factory Bot
- GitHub API

## Important Gems(Libraries):
* [rspec-rails](https://github.com/rspec/rspec-rails)
* [capybara](https://github.com/teamcapybara/capybara)
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
* [faraday](https://github.com/lostisland/faraday)
* [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)
* [simplecov](https://github.com/simplecov-ruby/simplecov)
* [orderly](https://github.com/simplecov-ruby/simplecov)

## Getting Started
1. Fork and clone the repo
2. Install any missing gems from gem file
3. Install gem packages with `bundle install`
4. Run `$ rails db:{create,migrate}`
5. Run `$ rake csv_load:all`
6. From your terminal run `$ rails s` and navigate to http://localhost:3000/ in your browser to navigate the app

## Testing
* RSpec and Capybara were used for unit and integration testing and project development adhered to TDD principles.
* Simplecov was used to track total test coverage.
* To run our test suite, RSpec, enter `$ bundle exec rspec` in the terminal.
* To see a coverage report enter `$ open coverage/index.html`

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)

## Additonal References
- [Base Repository](https://github.com/LawrenceWhalen/little-esty-shop) used for Turing's Backend Module 3.
- [Github Documentation](https://docs.github.com/en/rest) used for Github documentation.
