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

  it "calls with correct auth and returns 200 if no errors" do
    allow(Dwolla::Transactions).to receive(:send).and_return('It worked.')
    expect(Dwolla::Transactions).to receive(:send).with({
      destinationId: 'hello@world.com',
      destinationType: 'Email',
      amount: '1',
      pin: '1111'
    })
    post '/send_payment', format: :json, uid: '60', api_token: '1',
        amount: 1, email: 'hello@world.com', pin: 1111
    expect(response.response_code).to eq(200)
    expect(JSON.parse(response.body)).to eq({'message' => 'Success!'})
  end

  it "calls with correct auth and returns 400 if there are errors" do
    allow(Dwolla::Transactions).to receive(:send).and_raise('Invalid PIN.')
    expect(Dwolla::Transactions).to receive(:send).with({
      destinationId: 'hello@world.com',
      destinationType: 'Email',
      amount: '1',
      pin: '1111'
    })
    post '/send_payment', format: :json, uid: '60', api_token: '1',
        amount: 1, email: 'hello@world.com', pin: 1111
    expect(response.response_code).to eq(400)
    expect(JSON.parse(response.body)).to eq({'error' => 'Invalid PIN.'})
  end


end
