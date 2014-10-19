class DwollaController < ApplicationController

  skip_before_filter :verify_authenticity_token

  before_filter :authenticate_user!

  def send_payment
    Dwolla::api_key = ENV['DWOLLA_KEY']
    Dwolla::api_secret = ENV['DWOLLA_SECRET']
    Dwolla::token = current_user.access_token

    begin
      transaction_result = Dwolla::Transactions.send(
        destinationId: params[:email], pin: params[:pin],
        destinationType: 'Email', amount: params[:amount])

    rescue Exception => e
      render json: {error: e.to_s}, status: :bad_request and return
    end

    render json: {message: 'Success!'}, status: :ok
  end

  def credentials
  end

end
