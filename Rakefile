require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec


desc 'read efi-firmware-parser guids into YAML'
task :guids, [:path] do |_, params|
  GUID_REGEX = /'(?<name>[A-Z0-9_]+)': \[(?:(?:0x(?<chars>[0-9a-fA-F]+))(?:,\s)?)*\]/

  guid_sets = Dir.glob(File.join(params[:path], 'uefi_firmware/guids/*.py')).map do |guid_file|
    file_contents = File.read guid_file

    matches = file_contents =~ GUID_REGEX

    puts matches.inspect
  end
end