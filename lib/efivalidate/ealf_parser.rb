module EFIValidate
  class EALFParser
    attr_reader :header, :rows

    def initialize(data)
      @header = EFIValidate::EALFHeader.read(data)

      @rows = []
      @header.rows.times do
        @rows << EFIValidate::EALFRow.read(data)
      end
    end

    def self.read(file)
      EFIValidate::EALFParser.new(File.open(file))
    end
  end
end