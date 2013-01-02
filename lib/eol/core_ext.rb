Object.class_eval do
  def debug?
    ENV['DEBUG'] == '1'
  end

  def debug(name=nil)
    tap do
      if debug?
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
