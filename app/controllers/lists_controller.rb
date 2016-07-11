class ListsController < ApplicationController

  get '/lists' do
    if session[:user_id]
      @lists = List.all
      erb :'lists/tasks'
    else
      redirect to '/login'
    end
  end

  get '/lists/new' do
    if session[:user_id]
      erb :'lists/create_task'
    else
      redirect to '/login'
    end
  end

  post '/lists' do
    if params[:task] == "" || params[:due_date] == ""
      redirect to "/lists/new", locals: {message: "Please fill in all blanks."}
    else
      user = User.find_by_id(session[:user_id])
      @list = List.create(:task => params[:task], :due_date => params[:due_date], :user_id => user.id)
      redirect to "/lists/#{@list.id}"
    end
  end

  get '/lists/:id' do
    if session[:user_id]
      @list = List.find_by_id(params[:id])
      erb :'lists/show_task'
    else
      redirect to '/login'
    end
  end

  get '/lists/:id/edit' do
    if session[:user_id]
      @list = List.find_by_id(params[:id])
      if @list.user_id == session[:user_id]
        erb :'lists/edit_task'
      else
        redirect to '/lists'
      end
    else
      redirect to '/login'
    end
  end

  patch '/lists/:id' do
    if params[:task] == "" || params[:due_date] == ""
      redirect to "/lists/#{params[:id]}/edit", locals: {message: "Please fill in all blanks."}
    else
      @list = List.find_by_id(params[:id])
      @list.task = params[:task]
      @list.due_date = params[:due_date]
      @list.save
      redirect to "/lists/#{@list.id}"
    end
  end

  delete '/lists/:id/delete' do
    @list = List.find_by_id(params[:id])
    if session[:user_id]
      @list = List.find_by_id(params[:id])
      if @list.user_id == session[:user_id]
        @list.delete
        redirect to '/lists'
      else
        redirect to '/lists'
      end
    else
      redirect to '/login'
    end
  end

end
