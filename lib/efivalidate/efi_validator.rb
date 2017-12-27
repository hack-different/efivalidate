module EFIValidate
  class EFIValidator
    attr_reader :parser, :data, :errors

    def initialize(parser, data)
      @parser = parser
      @data = data
    end


    def validate!
      @errors = []

      @parser.rows.each do |row|
        @data.seek row.ealf_offset

        section_data = @data.read row.ealf_length

        calculated_hash = @parser.header.create_hash.hexdigest (section_data || '')

        @errors << EFIValidationError.new(row, section_data, calculated_hash) unless calculated_hash == row.hash
      end
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