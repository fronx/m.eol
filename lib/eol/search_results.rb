require 'json'
require 'eol/search_item'

module Eol
  class SearchResults
    attr_reader :total_results,
                :next_url,
                :items,
                :raw

    def initialize(api, json, page_params = {}, limit=nil)
      @raw = json
      @total_results = json['totalResults']
      @next_url = json['next']
      items    = limit ? json['results'][0...limit] : json['results']
      page_ids = items.map { |item| item['id'] }
      @items =
        Page.multi_load(api, page_ids, page_params).
          each_with_index.map do |page, index|
            SearchItem.new(api, items[index], page)
          end
    end

    def each(&block)
      @items.each(&block)
    end
  end
end
