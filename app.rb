require "sinatra"
require "sinatra/activerecord"

 
set :database, "sqlite3:todo.db"
 
class Todo < ActiveRecord::Base

end

  get "/?" do
    redirect "/todos"
  end

  # Get all of our routes
  get "/todos" do
    @todos = Todo.order("created_at DESC")
    erb :"todo/index"
  end  
 
  # Get the new todo form
  get "/todos/new" do
    @title = "New To Do"
    @todo = Todo.new
    erb :"todo/new"
  end
   
  # Add the todo to the database 
  post "/todos" do
    todo = Todo.new(params[:todo])
    if todo.save
      redirect "/"
    else
      erb :"todo/new"
    end
  end
   
  # Get the todo item via the id
  get "/todos/:id" do
    @todo = Todo.find(params[:id])
    @title = "test"
    erb :"todo/show"
  end

  # show the edit form
  get "/todos/edit/:id" do
    @todo = Todo.find(params[:id])
    @title = "Edit Form"
    erb :"todo/edit"
  end

  # Updates the todo with id in the database
  put "/todos/:id" do
    todo = Todo.find(params[:id])
    todo.completed_at = params[:todo][:done] ?  Time.now : nil
    if todo.update_attributes(params[:todo])
      redirect "/"
    else
      erb :"todo/edit"
    end
  end
   
  # Show the delete form
  get '/todos/delete/:id' do
    @todo = Todo.find(params[:id])
    erb :"todo/delete"
  end

  # Deletes the todo with id in the database
  delete '/todos/delete/:id' do
    if params.has_key?("ok")
      todo = Todo.find(params[:id])
      todo.destroy
      redirect '/'
    else
      redirect '/'
    end
  end


helpers do
 
  def prettify_date(time)
   time.strftime("%d %b %Y") unless time==nil
  end 

end

