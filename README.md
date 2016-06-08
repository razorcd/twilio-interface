[![Build Status](https://travis-ci.org/razorcd/twilio-interface.svg?branch=master)](https://travis-ci.org/razorcd/twilio-interface)

# twilio-interface

Web interface for sending and receiving messages with Twilio.

##[Live Demo](https://twilio-interface.herokuapp.com/)

#Development

- to start local server run `rake start` and visit `localhost:9292`
- to run tests run `rspec`
- to deploy to Heroku merge `development` branch to `production` branch in GitHub and CI will do the rest

#Contribution
This repository serves as a codebase demo. Therefor I am not merging any pull requests from other users.

Any requests for implementing new features are welcome. Just open an issue and I will consider it.

The license is MIT, so feel free to fork this repo and use/change it at will.

#TODO
- [x] extract list_messsages in a partial
- [x] style flash messages
- [ ] separate send_message form and list_messages in 2 views
- [x] deploy to Heroku and add CI (with Travis?)
- [ ] add test coverage (coveralls?)
- [ ] add security
- [x] state that no data is persisted (db/cache/logs)
- [ ] maybe store data in browsers local storage? (except credentials)
