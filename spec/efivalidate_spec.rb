require 'spec_helper'

RSpec.describe EFIValidate do
  it 'has a version number' do
    expect(EFIValidate::VERSION).not_to be nil
  end

  it 'finds a single row in a baseline with CORE_SEC' do
    path = File.join(__dir__, 'fixtures/MBP142.88Z.0167.B00.1708080034.0.ealf')
    parser = EFIValidate::EALFParser.read(path)

    expect(parser.rows.any?(&:core_sec?)).to be_truthy
  end

  it 'works on a correct firmware with SEC_CORE fixup' do
    path = File.join(__dir__, 'fixtures/MBP142.88Z.0167.B00.1708080034.0.ealf')
    parser = EFIValidate::EALFParser.read(path)

    expect(parser.rows.count).to eq 113
    expect(parser.header.ealf_size).to eq File.size(path)

    firmware_path = File.join(__dir__, 'fixtures/MBP142_0167_B00.fd')
    validator = EFIValidate::EFIValidator.new(parser, firmware_path)

    validator.validate

    validator.errors.each do |error|
      puts error
    end

    expect(validator.valid?).to be_truthy
  end

  it 'works on a correct firmware without SEC_CORE' do
    path = File.join(__dir__, 'fixtures/MBP114.88Z.0177.B00.1708080033.0.ealf')
    parser = EFIValidate::EALFParser.read(path)

    expect(parser.rows.count).to eq 188
    expect(parser.header.ealf_size).to eq File.size(path)

    firmware_path = File.join(__dir__, 'fixtures/MBP114_0177_B00.fd')
    validator = EFIValidate::EFIValidator.new(parser, firmware_path)

    validator.validate

    validator.errors.each do |error|
      puts error
    end

    expect(validator.valid?).to be_truthy
  end

  it 'fails on a corrupt firmware' do
    path = File.join(__dir__, 'fixtures/MBP114.88Z.0177.B00.1708080033.0.ealf')
    parser = EFIValidate::EALFParser.read(path)

    expect(parser.rows.count).to eq 188
    expect(parser.header.ealf_size).to eq File.size(path)

    firmware_path = File.join(__dir__, 'fixtures/MBP114_0177_B00_bad.fd')
    validator = EFIValidate::EFIValidator.new(parser, firmware_path)

    validator.validate

    validator.errors.each do |error|
      puts error
    end

    expect(validator.valid?).to be_falsey
  end

  it "can list each row in the table" do
    path = File.join(__dir__, 'fixtures/MBP142.88Z.0167.B00.1708080034.0.ealf')
    parser = EFIValidate::EALFParser.read(path)

    parser.rows.each do |row|
      puts row
    end
  end

  it 'fails to load a files with an invalid magic' do
    path = File.join(__dir__, 'fixtures/MBP114_0177_B00.fd')
    expect { EFIValidate::EALFParser.read(path) }.to raise_error(EFIValidate::EALFParser::EALFParseError)
  end

  it 'loads rows with the correct size hash' do
    path = File.join(__dir__, 'fixtures/MBP114.88Z.0177.B00.1708080033.0.ealf')
    parser = EFIValidate::EALFParser.read(path)

    expect(parser.rows.count).to eq 188
    expect(parser.header.ealf_size).to eq File.size(path)

    parser.rows.each do |row|
      expect(row.ealf_hash.size).to eq 32
    end
  end
end
