# Little Shop of Rails

## About this Project
[Little Shop of Rails](https://little-shop-of-rails.herokuapp.com/) is a solo project that builds off of a 4-person group project, [Little Esty Shop](https://little-rails-shop.herokuapp.com/). The original group project required our team to build a fictitious e-commerce platform where merchants and admins could manage inventory and fulfill customer invoices. 

In this solo extension, I explore Rails and ActiveRecord through creating and integrating bulk discounts, which are unique to specific merchants within the app. Work on bulk discounts is mine, along with the implementation for FactoryBot, WebMock, and the Nager.Date API for public holidays.

**Timeframe:** 9 days (for the original project) + 6 days (for my solo extension)

**Check out my app on Heroku:** [Little Shop of Rails](https://little-shop-of-rails.herokuapp.com/)

**View the original app here:** [Little Esty Shop](https://little-rails-shop.herokuapp.com/)

## Original Project (Little Esty Shop) Contributors

- Molly Krumholz (Me!)  
   [Github](https://github.com/mkrumholz) | [LinkedIn](https://www.linkedin.com/in/mkrumholz/)
- Sidarth Bagawandoss  
   [Github](https://github.com/Sidarth20) | [LinkedIn](https://www.linkedin.com/in/sidarth-bagawandoss-12220644/)
- Lawrence Whalen  
   [Github](https://github.com/LawrenceWhalen) | [LinkedIn](https://www.linkedin.com/in/lawrence-whalen-15996220a/)
- Aliya Merali  
   [Github](https://github.com/aliyamerali) | [LinkedIn](https://www.linkedin.com/in/aliyamerali/)

## Original Project Learning Goals
 - Practice designing a normalized database schema and defining model relationships
 - Utilize advanced routing techniques including namespacing to organize and group like functionality together
 - Utilize advanced active record techniques to perform complex database queries
 - Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Built With
- Ruby 2.7.2
- Rails 5.2.6
- ActiveRecord
- SQL
- RSpec (Capybara, Shoulda-Matchers)
- Factory Bot
- GitHub REST API
- Nager.Date API - NextPublicHolidays (V3)

## Important Gems(Libraries):
Testing
* [rspec-rails](https://github.com/rspec/rspec-rails)
* [capybara](https://github.com/teamcapybara/capybara)
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
* [simplecov](https://github.com/simplecov-ruby/simplecov)
* [orderly](https://github.com/jmondo/orderly)
* [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)
* [webmock](https://github.com/bblimke/webmock)

API Consumption
* [faraday](https://github.com/lostisland/faraday)

Front End
* [bootstrap](https://github.com/twbs/bootstrap-rubygem)
* [jquery](https://github.com/rails/jquery-rails)

## Getting Started
1. Fork and clone the repo
2. Install any missing gems from gem file
3. Install gem packages with `bundle install`
4. Run `$ rails db:{create,migrate}`
5. Run `$ rake csv_load:all`
6. From your terminal run `$ rails s` and navigate to http://localhost:3000/ in your browser to navigate the app

## Testing
* RSpec and Capybara were used for unit and integration testing and project development adhered to TDD principles.
* FactoryBot was used to generate test data.
* WebMock was used to stub out API requests and actual requests are blocked from the test environment.
* Simplecov was used to track total test coverage.
* To run our test suite, RSpec, enter `$ bundle exec rspec` in the terminal.
* To see a coverage report enter `$ open coverage/index.html`

## Phases and Original Project Documentation

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)

## Additonal References
- [Base Repository](https://github.com/turingschool-examples/little-esty-shop)
- [Github Documentation](https://docs.github.com/en/rest)
- [Nager.Date API Documentation](https://date.nager.at/API)
