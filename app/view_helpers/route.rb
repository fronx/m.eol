require 'faraday'

class Route
  def initialize(path_pattern)
    @path_pattern = path_pattern
  end

  def parts
    @path_pattern.to_s.split('/')
  end

  def to_s(params={})
    path =
      parts.map do |field|
        if field =~ /^:(.+)/
          params.delete($1.to_sym) ||
            raise(ArgumentError.new("#{field} not in #{params.inspect}"))
        else
          field
        end
      end.join('/')
    [ path, to_query(params) ].reject(&:empty?).join('?')
  end

private
  def to_query(hash)
    Faraday::Utils::ParamsHash.new.merge(hash).to_query
  end
end
