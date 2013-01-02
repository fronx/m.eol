require 'sinatra/base'
require 'eol/core_ext'
require 'eol/api'
require 'eol/page'
require 'view_helpers/view_mode'
require 'view_helpers/route'

class App < Sinatra::Base
  set :views, './app/views'

  def eol
    @eol ||= Eol::Api.new
  end

  ROUTES = {
    :search => Route.new("/search/:mode"),
  }

  VIEWS = {
    :search => ViewMode.new(%w[ list grid ]),
  }

  def init_search(mode, search_params={})
    next_mode = VIEWS[:search].at(mode).next
    @search_action = ROUTES[:search].to_s(:mode => mode)
    @toggle_link = {
      :href => ROUTES[:search].to_s(:mode => next_mode, :q => params[:q]),
      :next_mode => next_mode,
    }
    if params[:q]
      @search_results = eol.search(params[:q], search_params)
      @template = :"search_#{mode}"
    else
      @template = :index
    end
  end

  # HTML ------------------------------ #

  get '/' do
    init_search('list', {:images => 30, :text => 1})
    haml @template
  end

  get '/search/list' do
    init_search('list', {:images => 30, :text => 1})
    haml @template
  end

  get '/search/grid' do
    init_search('grid', {:images => 3, :text => 0})
    haml @template
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
