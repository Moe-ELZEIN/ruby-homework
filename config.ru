require "sinatra"
require "sinatra/contrib"
require "sinatra/reloader" if development?
require_relative "controllers/films_controllers.rb"
require_relative "models/film.rb"
# What does this do?
use Rack::MethodOverride
# What does this do?
run FilmsController
