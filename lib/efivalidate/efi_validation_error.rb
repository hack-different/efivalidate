module EFIValidate
  class EFIValidationError
    def initialize(row, data, hash)
      @row = row
      @data = data
      @calculated_hash = hash
    end

    def to_s
      @row.to_s
    end
  end
end