require 'spec_helper'

RSpec.describe EFIValidate::EALFParser do

  Dir.glob(File.join(__dir__, 'fixtures/baselines/*.ealf')) do |baseline|
    it "should validate baseline '#{baseline}'" do
      path = File.join(__dir__, 'fixtures/MBP114.88Z.0177.B00.1708080033.0.ealf')
      parser = EFIValidate::EALFParser.read(path)
    end
  end
end