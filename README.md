# GoogleplayReviews


## Installation

### mac

https://www.xquartz.org/

XQuartz-2.7.11.dmg

https://github.com/mozilla/geckodriver/releases/download/v0.18.0/geckodriver-v0.18.0-macos.tar.gz

### ubuntu

```
$ apt-get install xvfb firefox
$ wget https://github.com/mozilla/geckodriver/releases/download/v0.18.0/geckodriver-v0.18.0-linux64.tar.gz
$ tar zxf geckodriver-v0.18.0-linux64.tar.gz 
$ mv geckodriver /usr/local/bin/
```

Add this line to your application's Gemfile:

```ruby
gem 'googleplay_reviews'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install googleplay_reviews

## Usage

```
require 'googleplay_reviews'

scraper = GooglePlayReviews::Scraper.new('email', 'password')
scraper.login
scraper.scrape('package_id') do |items, page|
  p items.first # => GooglePlayReviews::Review
end
```