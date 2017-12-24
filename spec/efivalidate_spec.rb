require "spec_helper"

RSpec.describe EFIValidate do
  it "has a version number" do
    expect(EFIValidate::VERSION).not_to be nil
  end

  it "does something useful" do
    path = File.join(__dir__, 'fixtures/MBP114.88Z.0177.B00.1708080033.0.ealf')
    parser = EFIValidate::EALFParser.read(path)

    expect(parser.rows.count).to eq 188
    expect(parser.header.ealf_size).to eq File.size(path)

    firmware_path = File.join(__dir__, 'fixtures/MBP114_0177_B00.fd')
    validator = EFIValidate::EFIValidator.new(parser, File.open(firmware_path))
    expect(validator.is_valid?).to be_truthy
  end

  it "can list each row in the table" do
    path = File.join(__dir__, 'fixtures/MBP114.88Z.0177.B00.1708080033.0.ealf')
    parser = EFIValidate::EALFParser.read(path)

    parser.rows.each do |row|
      puts row
    end
  end

  it "fails to load a files with an invalid magic" do
    path = File.join(__dir__, 'fixtures/MBP114_0177_B00.fd')
    expect { EFIValidate::EALFParser.read(path) }.to raise_error(EFIValidate::EALFParser::EALFParseError)
  end

  it "loads rows with the correct size hash" do
    path = File.join(__dir__, 'fixtures/MBP114.88Z.0177.B00.1708080033.0.ealf')
    parser = EFIValidate::EALFParser.read(path)

    expect(parser.rows.count).to eq 188
    expect(parser.header.ealf_size).to eq File.size(path)

    parser.rows.each do |row|
      expect(row.ealf_hash_uuid.size).to eq 48
    end
  end
end
