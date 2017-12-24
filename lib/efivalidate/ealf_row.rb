require 'uuidtools'

module EFIValidate
  class EALFRow < IOStruct.new 'CCvLLa*',
                               :ealf_region,
                               :ealf_subregion,
                               :ealf_index,
                               :ealf_offset,
                               :ealf_size,
                               :ealf_hash_uuid

    attr_accessor :header

    def hash
      self.ealf_hash_uuid.each_byte.map { |b| b.to_s(16) }.join
    end

    def uuid
      UUIDTools::UUID.parse_raw(self.ealf_hash_uuid[0..16])
    end

    def to_s
      "<#{ "%02x" % self.ealf_region }:#{ "%02x" % self.ealf_subregion }:#{ "%04x" % self.ealf_index }:#{ "%08x" % self.ealf_offset }:#{ "%08x" % self.ealf_size}:#{self.uuid}:#{self.hash}>"
    end
  end
end