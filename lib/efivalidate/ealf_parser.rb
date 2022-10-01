module EFIValidate
  class EALFParser
    class EALFParseError < Exception; end

    attr_reader :header, :rows
    attr_accessor :filename

    def initialize(data)
      @header = EFIValidate::EALFHeader.read(data[0, EALFHeader::EALF_HERADER_SIZE])

      position = EALFHeader::EALF_HERADER_SIZE

      raise EALFParseError, 'File header magic mismatch.' unless @header.ealf_magic == EFIValidate::EALFHeader::EALF_MAGIC
      raise EALFParseError, 'Only SHA256 EALF is supported.' unless @header.ealf_hash_function == EFIValidate::EALFHeader::EALF_HASH_SHA256

      @rows = []
      @header.ealf_rows.times do
        row_data = data[position, @header.row_size]
        position += @header.row_size

        @rows << EFIValidate::EALFRow.read(row_data, @header.row_size).tap { |row| row.header = @header }
      end
    end

    def self.read(file)
      EFIValidate::EALFParser.new(File.open(file)).tap do |parser|
        parser.filename = file
      end
    end
  end
end