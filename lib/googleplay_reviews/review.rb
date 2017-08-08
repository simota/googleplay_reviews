# coding: utf-8
# -*- frozen_string_literal: true -*-

require 'time'

module GooglePlayReviews
  # Review
  class Review
    attr_reader :id,
                :nickname,
                :review,
                :review_timestamp,
                :response,
                :response_timestamp,
                :rating,
                :version

    def initialize(params)
      @id = params[:id]
      @nickname = params[:nickname]
      @review = params[:review]
      @review_timestamp = convert_timestamp(params[:review_date])
      @response = params[:response]
      @response_timestamp = convert_timestamp(params[:response_date])
      @rating = params[:rating]
      @version = params[:version]
    end

    def convert_timestamp(date)
      Time.parse(date).to_i rescue 0
    end
  end
end
