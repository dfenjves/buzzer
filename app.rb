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
      if params["pw"] == "laradanny"
        params = { :args => "BUZZ" }
        puts "https://api.spark.io/v1/devices/#{ENV['DEVICE']}/buzzIn?access_token=#{ENV['ACCESS_TOKEN']}"
        response = HTTParty.post("https://api.spark.io/v1/devices/#{ENV['DEVICE']}/buzzIn?access_token=#{ENV['ACCESS_TOKEN']}", body: params  )
        puts response.body, response.code, response.message, response.headers.inspect
        erb :index
      else
        "Wrong Access Code!"
      end
    end


    #helpers
    helpers do
      def partial(file_name)
        erb file_name, :layout => false
      end
    end

  end
end