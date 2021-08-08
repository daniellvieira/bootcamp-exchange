# frozen_string_literal: true

require 'rails_helper'
require 'json'
require './app/services/exchange_service'

describe ExchangeService do
  let(:source_currency) { 'USD' }
  let(:target_currency) { 'BRL' }
  let(:exchange_value) { 3.4546 }
  let(:api_return) do
    {
      currency: [
        {
          currency: "#{source_currency}/#{target_currency}",
          value: exchange_value,
          date: Time.now,
          type: 'Original'
        }
      ]
    }
  end

  before do
    allow(RestClient).to receive(:get) do
      OpenStruct.new(body: api_return.to_json)
    end
  end

  it '#call' do
    amount = rand(0..9999)
    expected_exchange = amount * exchange_value

    service_exchange = ExchangeService.new('USD', 'BRL', amount).call

    expect(service_exchange).to eq(expected_exchange)
  end
end

