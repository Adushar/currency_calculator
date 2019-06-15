require File.expand_path '../spec_helper.rb', __FILE__

describe "currency coverter" do
  it "should display index page" do
    get '/'

    expect(last_response.body).to include("Currency calculator")
  end

  it "should convert USD to RUB" do
    get '/convert', {
      from: "USD",
      to: "RUB",
      amount: 1
    }

    json_response = JSON.parse last_response.body
    expect(json_response["amount"]).to eq 64.26
  end

  it "should convert USD to USD" do
    get '/convert', {
      from: "USD",
      to: "USD",
      amount: 1
    }

    json_response = JSON.parse last_response.body
    expect(json_response["amount"]).to eq 1
  end

  it "should response with Bad Request" do
    get '/convert'

    expect(last_response.status).to eq(400)
  end
end
