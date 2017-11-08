module EFIValidate
  class EALFHeader < IOStruct.new 'a4LLC',
                                  :ealf_magic,
                                  :ealf_rows,
                                  :ealf_size,
                                  :ealf_hash_function,
                                  :ealf_zeros,
                                  :ealf_row_offset,
                                  :ealf_signature_size


  end
end