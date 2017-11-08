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
  end
end
