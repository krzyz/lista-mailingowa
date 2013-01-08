# encoding: UTF-8
require 'bundler/setup'
require 'sinatra'
require 'data_mapper'
require 'bcrypt'
require 'rack-flash'



class Index < Sinatra::Base
  enable :sessions
  use Rack::Flash, sweep: true

  helpers do

    def login?
      if session[:username].nil?
        return false
      else
        return true
      end
    end

    def new_password(password)
      password_salt = BCrypt::Engine.generate_salt
      password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      success = false
      if Admin.count == 0
        newadmin = Admin.create(
          salt:          password_salt,
          password_hash: password_hash
        )
        success = newadmin.saved?
      else
        admin = Admin.first
        admin.attributes = {
          salt:          password_salt,
          password_hash: password_hash
        }
        success = admin.save
      end

      return success # true if success, false otherwise
    end

  end

  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/db/mailing_list.db")
  configure :test do
    DataMapper.setup(:default, "sqlite::memory:")
  end

  class UserEmail
    include DataMapper::Resource

    property :id,         Serial
    property :email,      String,  required: true
    property :created_at, DateTime
  end

  class Admin
    include DataMapper::Resource

    property :id,            Serial
    property :salt,          String, required: true
    property :password_hash, String, required: true, length: 60
  end

  DataMapper.finalize
  UserEmail.auto_upgrade!
  Admin.auto_upgrade!

  get '/stylesheets/style.css' do
  #  header 'Content-Type' => 'text/css; charset=utf-8'
    sass :style
  end

  get '/' do
    erb :index
  end

  post '/' do
    UserEmail.create(
      email:      params[:email],
      created_at: Time.now
    )
    redirect '/'
  end

  get '/admin' do
    redirect '/login' unless login?
    erb :admin, locals: { users: UserEmail.all }
  end

  post '/admin' do
    redirect '/login' unless login?
    success = new_password( params[:password] )
    if success == true
      flash[:notify] = 'Zmiana hasła zakończona sukcesem.'
    else
      flash[:error] = 'Nie udało się zmienić hasła.'
    end
    redirect back
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    user = Admin.first
    if params[:name] == 'admin' && 
        user[:password_hash] == BCrypt::Engine.hash_secret(params[:password], user[:salt])
      session[:username] = "admin"
      redirect '/admin'
    end
    redirect back
  end

  get '/logout' do
    session[:username] = nil
    redirect '/'
  end

end

Index.run!
