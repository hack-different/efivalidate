module EFIValidate
  # Class that represents a single run of a validator against a firmware
  class EFIValidator
    attr_reader :parser, :data, :errors

    def initialize(parser, data)
      @parser = parser

      @data = data

      perform_core_sec_fixup if @parser.rows.any?(&:core_sec?)
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
      @data[offset, length] || ''
    end

    def perform_core_sec_fixup
      # Apple zeros out what appears to be a hash and checksum before validating the SEC_CORE region

      @data[-0x100, 0x80] = "\0" * 0x80
      @data[-0x04, 0x04] = "\0" * 0x04
    end

    def perform_bios_region_measurement

    end

    def validate
      validate! unless @errors
    end

    def filename
      @parser.filename
    end

    def valid?
      validate

      errors.count.zero?
    end
  end
end