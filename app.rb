require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'json'
require 'haml'

get "/" do
  @rate_names = currency_hash.keys

  haml :index
end

get "/convert" do
  # We dont need params evaluation because it is get param and we are not writing data
  rate, from, to  = currency_hash, params[:from], params[:to]

  if rate && from && to
    amount = if rate[from] != rate[to]                                    # if it isn`t the same currency
      (params[:amount].to_f * rate[to] / rate[from]).round(2)             # calculate rate
    else
      params[:amount].to_f.round(2)
    end

    content_type :json
    {
      :from => from,
      :to => to,
      :amount => amount
    }.to_json
  else
    status 400
  end
end

private

def currency_hash
  rates_list = File.open "./public/rates.json"
  JSON.load rates_list
end
