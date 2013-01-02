require 'eol/core_ext'
require 'eol/search_results'
require 'faraday'
require 'typhoeus'
require 'yajl/json_gem'

module Eol
  class MyCustomMiddleware
    def call(env)
      @app.call(env).on_complete do |env|
        env[:response]
      end
    end
  end

  class Api
    def initialize()
      @http = Faraday.new('http://eol.org/api/') do |conn|
        conn.request :url_encoded
        conn.response :logger
        conn.adapter :typhoeus
      end
    end

    def search(query, page_params={}, limit=nil)
      SearchResults.new(
        self,
        get("search/1.0.json", { :q => query }).debug('get:search'),
        page_params,
        limit
      )
    end

    def multi_get(paths, params={})
      result = nil
      @http.in_parallel do
        result = paths.map do |path|
          @http.get(path, params)
        end
      end
      result.map do |item|
        JSON.parse(item.body)
      end
    end

    def get(path, params={})
      JSON.parse(
        @http.get(path, params).body
      )
    end
  end
end
