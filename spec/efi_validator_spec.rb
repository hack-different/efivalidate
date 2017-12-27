require 'spec_helper'

RSpec.describe EFIValidate::EFIValidator do
  FIRMWARE_FILE_LIST = Dir.glob(File.join(__dir__, 'fixtures/firmware/*')).to_a

  FIRMWARE_FILE_LIST.each do |firmware|
    it "should work for Intel FD firmware '#{firmware}'" do
      efi = File.open firmware

    end
  end

  FIRMWARE_FILE_LIST.each do |firmware|
    it "should find a baseline that matches #{firmware}" do

      results = Dir.glob(File.join(__dir__, 'fixtures/baselines/*.ealf')).to_a.map do |baseline|
        parser = EFIValidate::EALFParser.read(baseline)

        validator = EFIValidate::EFIValidator.new(parser, File.open(firmware))

        validator.validate
        [ baseline, validator.errors.count ]
      end

      puts "Looking for baseline for #{firmware}"

      closest = results.min { |a, b| a[1] <=> b[1] }
      puts "Closest match #{closest}"

      parser = EFIValidate::EALFParser.read(closest[0])

      validator = EFIValidate::EFIValidator.new(parser, File.open(firmware))

      validator.validate
      validator.errors.each do |error|
        puts error
      end

      expect(closest[1]).to eq 0
    end
  end
end