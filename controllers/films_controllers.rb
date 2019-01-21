class FilmsController < Sinatra::Base

configure :development do
  register Sinatra::Reloader
end

# sets root as the parent-directory of the current files
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  # INDEX
  get "/" do
    # This is what ruby secretly does with attr_accessor to define the properties of our class
    @films = Film.all
    erb:"films/index.html"
  end

  # NEW
  get "/new" do
    @film = Film.new
    erb :"films/new.html"
  end

  # SHOW # Find out what you put after /
  get "/:id" do
    id = params[:id].to_i
    @film = Film.find id
    erb:"films/show.html"
  end

  # EDIT
  get "/:id/edit" do
    id = params[:id]
    @film = Film.find id
    erb :"films/edit.html"
  end

  # CREATE
  post "/" do
    # creating a new index
    film = Film.new
    # setting title and body
    film.title = params[:title]
    film.body = params[:body]

    film.save
    redirect "/"
  end

  #UPDATE
  put "/:id" do
    id = params[:id].to_i
    film = Film.find id

    film.title = params[:title]
    film.body = params[:body]

    film.save

    redirect "/#{id}"
  end

  #DESTROY
  delete "/:id" do
    id = params[:id].to_i
  #Delete at method that deletes something from an array at what index you give it
    Film.delete id

    redirect "/"
  end

end
