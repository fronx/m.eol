module Eol
  class DataObject
    attr_reader :identifier,
                :data_rating,
                :title,
                :description,
                :mime_type,
                :source_url,
                :data_type

    def initialize(json)
      @identifier    = json['identifier']
      @data_rating   = json['dataRating']
      @title         = json['title']
      @description   = json['description']
      @mime_type     = json['mimeType']
      @source_url    = json['source']   # link here!
      @data_type     = json['dataType'] # data type uri
    end
  end
end
