require 'uuidtools'

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

  ROW_GUIDS = { "ef7f23e1-7ba0-a64a-baea-33edff15ba3f" => 'BIOS_EMPTY_SPACE',
                "d954937a-6804-4a44-81ce-0bf617d890df" => 'EFI_FLASH_FILE_SYSTEM_VOLUME',
                "8c1b00bd-716a-7b48-a14f-0c2a2dcf7a5d" => 'APPLE_IMMUTABLE_FIRMWARE_VOLUME',
                "78e58c8c-3d8a-1c4f-9935-896185c32dd3" => 'EFI_FIRMWARE_FILE_SYSTEM_2_VOLUME',
                "a980b9e3-e35f-e548-9b92-2798385a9027" => 'EMPTY_SHMOO_FIRMWARE_VOLUME',
                "484c38ef-0cab-544b-8ed9-0710ad500c0f" => 'FIELD_SHMOO_FIRMWARE_VOLUME',
                "0a369089-370e-2245-a8a7-a55041013deb" => 'DALE_SHMOO_FIRMWARE_VOLUME',
                "97213d15-bd29-dc44-ac59-887f70e41a6b" => 'MICROCODE_FIRMWARE_VOLUME',
                "8d2bf1ff-9676-8b4c-a985-2747075b4f50" => 'EFI_SYSTEM_NNRAM_FIRMWARE_VOLUME',
                "096de3c3-9482-974b-a857-d5288fe33e28" => 'BIOS_IDENTIFIER',
                "b57d69bb-60ed-ac46-8754-7580b8b27ed0" => 'APPLE_SEC_VOLUMES_FILE',
                "2e06a01b-79c7-8245-8566-336ae8f78f09" => 'SEC_CORE',
                "17706906-2e5f-225e-ad94-5816399c720a" => 'APPLE_ROM_MANIFEST',
                "a3b9f5ce-6d47-7f49-9fdc-e98143e0422c" => 'AMI_NVRAM_FILE',
                "24465000-598a-eb4e-bd0f-6b36e96128e0" => 'PHOENIX_NVRAM_FIRMWARE_VOLUME' }

  ROW_GUIDS.each do |key, value|
    const_set(value, UUIDTools::UUID.parse(key))
  end
end