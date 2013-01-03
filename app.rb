require 'bundler/setup'
require 'sinatra'
require 'data_mapper'

#before do
#  # Strip the last / from the path
#  request.env['PATH_INFO'].gsub!(%r[/$], '')
#end

configure do
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/db/mailing_list.db")

  class User
    include DataMapper::Resource

    property :id,         Serial
    property :email,      String,  :required => true
    property :created_at, DateTime
  end

  DataMapper.finalize
  User.auto_upgrade!

end

get '/stylesheets/style.css' do
#  header 'Content-Type' => 'text/css; charset=utf-8'
  sass :style
end

get '/' do
  erb :index
end

post '/' do
  @user = User.create(
    :email      => params[:email],
    :created_at => Time.now
  )
end

get '/admin' do
  if authorized?
    erb :admin
  else
    erb :login
  end
end

post '/admin' do

end
