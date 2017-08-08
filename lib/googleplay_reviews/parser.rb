# coding: utf-8
# -*- frozen_string_literal: true -*-

require 'uri'
require_relative './review'

module GooglePlayReviews
  # Parser
  class Parser
    def initialize(element)
      @element = element
    end

    def parse
      params = {
        id: parse_review_id,
        nickname: parse_nickname,
        review: parse_review,
        review_date: parse_review_date,
        response: parse_response,
        response_date: parse_response_date,
        rating: parse_rating,
        version: parse_version
      }
      GooglePlayReviews::Review.new(params)
    end

    private

    def extract_review_id(url)
      words = url.partition('reviewid=')
      words.last
    end

    def review_id_link?(tag)
      !tag['title'].nil? && tag['title'] == 'このレビューへのリンク'
    end

    def parse_review_id
      @element.css('a').each do |a|
        return extract_review_id(a['href']) if review_id_link?(a)
      end
    end

    def parse_nickname
      @element.css('strong').first.text
    end

    def parse_review
      @element.css('pre').first.css('span').text
    end

    def parse_review_date
      @element.css('span').each do |span|
        s = span.text.match(%r{（(\d{4}\/\d{2}\/\d{2}、\d{1,2}:\d{2})）})
        return s[1].sub('、', ' ') unless s.nil?
      end
    end

    def parse_response
      @element.css('pre').last.text
    end

    def parse_response_date
      date = []
      @element.css('strong').each do |strong|
        head = strong.text.match(%r{(\d{4}\/\d{2}\/\d{2})})
        date << head[1] unless head.nil?
        tail = strong.text.match(/(\d{2}:\d{1,2})/)
        date << tail[1] unless tail.nil?
        return date.join(' ') if date.size == 2
      end
    end

    def parse_rating
      @element.css('span').each do |span|
        if span.attribute('title')&.text&.include?('星中')
          return span.attribute('title').text[6]
        end
      end
    end

    def parse_version
      sections = @element.css('section')
      sections[sections.size - 2].css('dd').last.text
    end
  end
end
