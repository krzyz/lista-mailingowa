require 'sinatra'

before do
  # Strip the last / from the path
  request.env['PATH_INFO'].gsub!(%r[/$], '')
end

get '/' do
  erb :index
end

get '/stylesheets/style.css' do
#  header 'Content-Type' => 'text/css; charset=utf-8'
  sass :style
end
