# frozen_string_literal: true

require 'rest-client'
require 'json'
class ExchangeService
  def initialize(source_currency, target_currency, amount)
    @source_currency = source_currency
    @target_currency = target_currency
    @amount = amount.to_f
  end

  def call
    value = exchange
    value * amount
  rescue RestClient::ExceptionWithResponse => exception
    exception.response
  end

  private

  attr_reader :source_currency, :target_currency, :amount

  def exchange
    exchange_api_url = Rails.application.credentials[:currency_api_url]
    exchange_api_key = Rails.application.credentials[:currency_api_key]
    url = "#{exchange_api_url}" \
          "?token=#{exchange_api_key}" \
          "&currency=#{source_currency}/#{target_currency}"
    res = RestClient.get url
    JSON.parse(res.body)['currency'][0]['value'].to_f
  end
end

