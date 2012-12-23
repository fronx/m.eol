module Eol
  class DataTypes
    ROOT_URL = 'http://purl.org/dc/dcmitype/'

    def self.text
      "#{ROOT_URL}Text"
    end

    def self.image
      "#{ROOT_URL}StillImage"
    end
  end
end
