# coding: utf-8
# -*- frozen_string_literal: true -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#require_relative './version'

Gem::Specification.new do |spec|
  spec.name          = 'googleplay_reviews'
  spec.version       = '0.0.1'
#  spec.version       = GooglePlayReviews::VERSION
  spec.authors       = ['simota']
  spec.email         = ['simota@me.com']

  spec.summary       = ''
  spec.description   = ''
  spec.homepage      = ''

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'TODO: Set to http://mygemserver.com'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'mechanize', '~> 2.7.5'
  spec.add_dependency 'capybara', '~> 2.15.0'
  spec.add_dependency 'poltergeist', '~> 1.15.0'
  spec.add_dependency 'selenium-webdriver', '~> 3.4.4'
  spec.add_dependency 'headless', '~> 2.3.1'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry', '~> 0.10.4'
end
