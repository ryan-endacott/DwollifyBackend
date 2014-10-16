class DwollaController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def send_payment
    Dwolla::api_key = ENV['DWOLLA_KEY']
    Dwolla::api_secret = ENV['DWOLLA_SECRET']
    Dwolla::debug = true

    user = User.first
    Dwolla::token = user.access_token

    transaction_id = Dwolla::Transactions.send(
      destinationId: 'rzeg24@gmail.com', pin: 9999,
      destinationType: 'Email', amount: 1.00)

    return "#{transaction_id}"

  end

end
