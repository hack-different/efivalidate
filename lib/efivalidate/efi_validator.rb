module EFIValidate
  # Class that represents a single run of a validator against a firmware
  class EFIValidator
    attr_reader :parser, :data, :errors

    def initialize(parser, file)
      @parser = parser
      @data = file.read

      # perform_core_sec_fixup if @parser.rows.any?(&:core_sec?)
    end

    def validate!
      @errors = []

      @parser.rows.reject(&:privacy_row?).each do |row|
        section_data = get_region(row.ealf_offset, row.ealf_length)

        calculated_hash = @parser.header.create_hash.hexdigest section_data

        @errors << EFIValidationError.new(row, section_data, calculated_hash) unless calculated_hash == row.hash
      end
    end

    def get_region(offset, length)
      @data[offset, length]
    end

    def perform_core_sec_fixup
      [-0x100..0x80, -0x04..0x04].each do |range|
        data[range] = '\0' * range.length
      end
    end

    def validate
      validate! unless @errors
    end

    def valid?
      validate

      errors.count.zero?
    end
  end
end