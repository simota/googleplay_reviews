# coding: utf-8
# -*- frozen_string_literal: true -*-

require 'capybara/poltergeist'
require 'selenium-webdriver'
require 'nokogiri'
require 'headless'
require_relative './parser'

module GooglePlayReviews
  # Scraper
  class Scraper
    SLEEP_TIME = 3
    REVIEW_URL = 'https://play.google.com/apps/publish'

    def initialize(email, password)
      @email = email
      @password = password
      setup_display
      @browser = create_browser
    end

    def setup_display
      @headless = Headless.new
      @headless.start
    end

    def create_browser
      Capybara.register_driver :selenium_firefox do |app|
        Capybara::Selenium::Driver.new(app, browser: :firefox)
      end
      Capybara::Session.new(:selenium_firefox)
    end

    def login
      load_login_page
      sleep(1)
      input_email
      sleep(1)
      input_password
      sleep(1)
      self
    end

    def scrape(package, max_page = nil)
      @browser.visit(page_url(package))
      sleep(SLEEP_TIME)
      reviews = parse(@browser.body)
      page = 1
      yield(reviews, page) if block_given?
      loop do
        break if !max_page.nil? && page >= max_page
        break unless next?
        next_button.click
        sleep(SLEEP_TIME)
        items = parse(@browser.body)
        page += 1
        yield(items, page) if block_given?
        reviews.concat(items)
      end
      reviews
    end

    def parse(html)
      doc = Nokogiri::HTML(html)
      doc.css('article').map { |a| GooglePlayReviews::Parser.new(a).parse }
    end

    private

    def load_login_page
      @browser.visit(REVIEW_URL)
    end

    def input_email
      @browser.find('input[type="email"]').native.send_key(@email)
      @browser.find('#identifierNext').click
    end

    def input_password
      @browser.find('input[type="password"]').native.send_key(@password)
      @browser.find('#passwordNext').click
    end

    def next?
      button = next_button
      return false if button.nil? || button['disabled']
      true
    end

    def next_button
      @browser.find('button[aria-label="次のページ"]')
    end

    def page_url(package)
      "#{REVIEW_URL}/#ReviewsPlace:p=#{package}"
    end
  end
end
