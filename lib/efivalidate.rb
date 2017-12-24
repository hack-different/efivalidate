require "efivalidate/version"
require 'iostruct'

module EFIValidate
  # Your code goes here...
  autoload :EALFHeader, 'efivalidate/ealf_header'
  autoload :EALFRow, 'efivalidate/ealf_row'
  autoload :EALFParser, 'efivalidate/ealf_parser'
  autoload :EFIValidator, 'efivalidate/efi_validator'
end
