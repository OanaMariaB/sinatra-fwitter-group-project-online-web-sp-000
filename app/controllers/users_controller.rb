class UsersController < ApplicationController

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username]== "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(
        username: params[:username], 
        email: params[:email], 
        password: params[:password]
          )
        session[:user_id] = @user.id
        redirect '/tweets'
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    binding.pry
    @user = User.find_by(username: params[:username])
    if @user and @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end

  end
  

end #class
