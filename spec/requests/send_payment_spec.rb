# Feature: POST to send_payment
#   As a user of the chrome extension
#   I want to send Dwolla payments to an email.
describe "POST 'send_payment'", :omniauth do

  before(:each) do
    user = create(:user, uid: '60', api_token: '1')
  end

  it "fails with incorrect auth" do
    post '/send_payment', format: :json, uid: '0', api_token: '500'
    expect(response.response_code).to eq(401)
  end

  it "succeeds with correct oauth" do
    post '/send_payment', format: :json, uid: '60', api_token: '1'
    expect(response.response_code).to eq(200)
  end

end
