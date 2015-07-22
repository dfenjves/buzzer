require 'bundler'
Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end
require './env' if File.exists?('env.rb')

module Name
  class App < Sinatra::Application

    #configure
    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, 'public'
    end

    #filters

    #routes
    get '/' do
      erb :index
    end

    post '/'  do
      if params["pw"] == ENV['CODE']
        params = { :args => "BUZZ" }
        puts "https://api.spark.io/v1/devices/#{ENV['DEVICE']}/buzzIn?access_token=#{ENV['ACCESS_TOKEN']}"
        response = HTTParty.post("https://api.spark.io/v1/devices/#{ENV['DEVICE']}/buzzIn?access_token=#{ENV['ACCESS_TOKEN']}", body: params  )
        puts response.body, response.code, response.message, response.headers.inspect
        erb :index
      else
        erb :error
      end
    end

    #Attempting twilio integration
    get '/sms-quickstart' do
      twiml = Twilio::TwiML::Response.new do |r|
        r.Message "Hey Monkey. Thanks for the message!"
      end
    twiml.text
    end


    #helpers
    helpers do
      def partial(file_name)
        erb file_name, :layout => false
      end
    end

  end
end