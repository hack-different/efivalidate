module EFIValidate
  class EFIValidator
    attr_reader :parser, :data, :errors

    def initialize(parser, data)
      @parser = parser
      @data = data
    end


    def validate!
      @errors = []


    end

    def validate
      self.validate! unless @errors
    end

    def is_valid?
      self.validate

      self.errors.count == 0
    end
  end
end