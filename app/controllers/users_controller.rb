class UsersController < ApplicationController

  get '/signup' do
    if !session[:user_id]
      erb :'users/create_user', locals: {message: "Please sign up before you log in."}
    else
      redirect to '/lists'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup', locals: {message: "Please fill in all blanks."}
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/lists'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect to '/lists'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/lists'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if session[:user_id]
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
