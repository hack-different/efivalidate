require 'uuidtools'

module EFIValidate
  # A class that represents a region of an EFI firmware with a valid hash for the region
  #
  # A EALF file is a collection of regions an
  class EALFRow < IOStruct.new 'CCvLLa16a*',
                               :ealf_region,
                               :ealf_subregion,
                               :ealf_index,
                               :ealf_offset,
                               :ealf_length,
                               :ealf_uuid,
                               :ealf_hash

    attr_accessor :header

    def hash
      self.ealf_hash.each_byte.map { |b| '%02x' % b }.join
    end

    def uuid
      UUIDTools::UUID.parse_raw(self.ealf_uuid)
    end

    def to_s
      "<#{ '%02x' % self.ealf_region }:#{ '%02x' % self.ealf_subregion }:#{ "%04x" % self.ealf_index }:#{ "%08x" % self.ealf_offset }:#{ "%08x" % self.ealf_length}:#{self.uuid}:#{self.hash}>"
    end
  end
end