require 'uuidtools'
require 'yaml'

module EFIValidate
  # A class that represents a region of an EFI firmware with a valid hash for the region
  #
  # A EALF file is a collection of regions an
  class EALFRow < IOStruct.new 'CCvLLa16a*',
                               :ealf_component,
                               :ealf_region,
                               :ealf_master,
                               :ealf_offset,
                               :ealf_length,
                               :ealf_uuid,
                               :ealf_hash

    attr_accessor :header

    def hash
      ealf_hash.each_byte.map { |b| '%02x' % b }.join
    end

    def uuid
      UUIDTools::UUID.parse_raw(ealf_uuid)
    end

    def privacy_row?
      ealf_hash.each_byte.all?(&:zero?)
    end

    def core_sec?
      uuid == SEC_CORE
    end

    def to_s
      format '<%02x:%02x:%04x:%08x:%08x:%s:%s>', ealf_component, ealf_region, ealf_master, ealf_offset, ealf_length, format_uuid, hash
    end

    def format_uuid
      format '%36.36s', (EFIValidate::ROW_GUIDS[uuid.to_s] || uuid)
    end
  end

  def self.load_guids
    apple_guids = YAML.load_file(File.join(__dir__, 'apple_guids.yaml'))

    puts apple_guids.inspect

    const_set(:ROW_GUIDS, apple_guids['guid_types'])

    apple_guids['guid_types'].each do |key, value|
      const_set(value.to_sym, key)
    end
  end

  load_guids
end