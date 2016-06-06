[![Build Status](https://travis-ci.org/razorcd/twilio-interface.svg?branch=master)](https://travis-ci.org/razorcd/twilio-interface)

# twilio-interface

Web interface for sending and receiving messages with Twilio.

##[Live Demo](http://twilio-interface.herokuapp.com/)

#Development

- to start local server run `bundle exec thin start -r config.ru -p 9292` and visit `localhost:9292`
- to run tests run `rspec`
- to deploy to Heroku merge `development` branch to `production` branch in GitHub and CI will do the rest

#TODO
- [x] extract list_messsages in a partial
- [x] style flash messages
- [ ] separate send_message form and list_messages in 2 views
- [X] deploy to Heroku and add CI (with Travis?)
- [ ] add test coverage (coveralls?)
