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
    :page   => Route.new("/pages/:id"),
  }

  VIEWS = {
    :search => ViewMode.new(%w[ list ]),
  }

  LANGS = %w[ en de fr ru es ]

  COOKIE_LANGS = 'm.eol__langs'

  def init_lang
    @langs = request.cookies[COOKIE_LANGS].to_s.split('|').compact
    @langs = %w[ en ] if @langs.empty?
  end

  def init_search(mode, search_params={})
    next_mode = VIEWS[:search].at(mode).next
    @search_action = ROUTES[:search].to_s(:mode => mode)
    @q = params[:q]
    @toggle_link = {
      :href => ROUTES[:search].to_s(:mode => next_mode, :q => params[:q]),
      :next_mode => next_mode,
    }
    if params[:q].to_s.strip != ''
      @search_results = eol.search(params[:q], search_params)
      @template = :"search_#{mode}"
    else
      @template = :index
    end
  end

  # HTML ------------------------------ #

  get '/' do
    init_lang
    init_search('list', {:images => 30, :text => 1})
    haml @template
  end

  get '/search/list' do
    init_lang
    init_search('list', {:images => 30, :text => 1})
    haml @template
  end

  get '/pages/:id' do
    init_lang
    @q =
      if request.referer && (query = URI.parse(request.referer).query)
        Hash[URI.decode_www_form(query)]['q']
      end
    @page = Eol::Page.load(eol, params[:id], {:images => 100, :text => 10})
    haml :page
  end
end
