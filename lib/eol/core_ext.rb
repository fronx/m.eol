Object.class_eval do
  def debug(name=nil)
    tap do
      if ENV['DEBUG'] == '1'
        result = block_given? ? yield(self) : self
        puts(
          [name, result.inspect].
            compact.
            join(' -- ')
        )
      end
    end
  end
end
