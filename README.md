# LendingHome Rate Flow App

Base rails app used in the lendinghome engineering "Rate Flow" interview exercise.


## Notes to the candidates

* You should have been given some sort of guide before getting here, if not, reach out to us.
* Feel free to add or remove and library from this project, use the tools you prefer.


## Setup

This is a [rails](https://rubyonrails.org/), hence requires you to run [ruby](https://www.ruby-lang.org/en/).

If you don't have ruby installed, you should install it, [see here](https://www.ruby-lang.org/en/documentation/installation/).


once you have ruby installed, you will need to bootstrap the app.
run in a terminal:

```
gem install bundler
bundle install
bundle exec rake db:reset
```

you should now be able to start the app by running:

```
bundle exec rails start
```
