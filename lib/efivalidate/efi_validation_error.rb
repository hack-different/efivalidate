module EFIValidate
  class EFIValidationError
    attr_reader :row, :data, :hash

    def initialize(row, data, hash)
      @row = row
      @data = data
      @hash = hash
    end

    def to_s
      "Expected #{row} to be #{@hash}"
    end
  end
end