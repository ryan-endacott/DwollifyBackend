class DwollaController < ApplicationController

  skip_before_filter :verify_authenticity_token

  before_filter :authenticate_user!

  def send_payment
    Dwolla::api_key = ENV['DWOLLA_KEY']
    Dwolla::api_secret = ENV['DWOLLA_SECRET']
    Dwolla::token = current_user.access_token

    transaction_result = Dwolla::Transactions.send(
      destinationId: params[:email], pin: params[:pin],
      destinationType: 'Email', amount: params[:amount])

    return "#{transaction_result}"
  end

end
