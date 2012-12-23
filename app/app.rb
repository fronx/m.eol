require 'sinatra/base'
require 'eol/core_ext'
require 'eol/api'
require 'eol/page'

class App < Sinatra::Base
  set :views, './app/views'

  def eol
    @eol ||= Eol::Api.new
  end

  # HTML ------------------------------ #

  get '/' do
    haml :index
  end

  get '/search/list' do
    if params[:q]
      @search_results = eol.search(params[:q], {:images => 30, :text => 1})
      haml :search_list
    else
      haml :index
    end
  end

  get '/search/grid' do
    @search_action = '/search/grid'
    if params[:q]
      @search_results = eol.search(params[:q], {:images => 3, :text => 0})
      haml :search_grid
    else
      haml :index
    end
  end

  get '/pages/:id' do
    @page = Eol::Page.load(eol, params[:id], {:images => 1000, :text => 30})
    haml :page
  end

  get '/pages/:id/images/:image_identifier' do
    @page = Eol::Page.load(eol, params[:id], {:images => 1000, :text => 0})
    @image = @page.image_by_id(params[:image_identifier])
    haml :image
  end
end
