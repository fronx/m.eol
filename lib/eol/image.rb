require 'eol/data_object'

module Eol
  class Image < DataObject
    attr_reader :url,
                :thumbnail_url,
                :thumbnail_square_url

    def initialize(json)
      super(json)
      json.debug('image')
      @url           = json['eolMediaURL']
      @thumbnail_url = json['eolThumbnailURL'] # 98x68
      @thumbnail_square_url = json['eolThumbnailURL'].gsub('_98_68', '_88_88')
    end
  end
end
