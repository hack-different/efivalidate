module EFIValidate
  class EALFRow < IOStruct.new 'CCvLLa16a32',
                               :ealf_region,
                               :ealf_subregion,
                               :ealf_index,
                               :ealf_offset,
                               :ealf_size,
                               :ealf_guid,
                               :ealf_hash

  end
end