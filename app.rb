require 'bundler'
Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

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
      params = { :args => "BUZZ" }
      response = HTTParty.post("https://api.spark.io/v1/devices/#{ENV[DEVICE]}/buzzIn?access_token=#{ENV[ACESS_TOKEN]}", body: params  )
      puts response.body, response.code, response.message, response.headers.inspect
      erb :index
    end


    #helpers
    helpers do
      def partial(file_name)
        erb file_name, :layout => false
      end
    end

  end
end