module EFIValidate
  class EALFParser
    class EALFParseError < Exception; end

    attr_reader :header, :rows

    def initialize(data)
      @header = EFIValidate::EALFHeader.read(data, 97)

      raise EALFParseError, 'File header magic mismatch.' unless @header.ealf_magic == EFIValidate::EALFHeader::EALF_MAGIC
      raise EALFParseError, 'Only SHA256 EALF is supported.' unless @header.ealf_hash_function == EFIValidate::EALFHeader::EALF_HASH_SHA256

      @rows = []
      @header.ealf_rows.times do
        @rows << EFIValidate::EALFRow.read(data, @header.row_size).tap { |row| row.header = @header }
      end
    end

    def self.read(file)
      EFIValidate::EALFParser.new(File.open(file))
    end
  end
end