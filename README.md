# `efivalidate`

Important: See `FORMAT.md`

`efivalidate` is a ruby utility to take a given input EFI payload from macOS and to compare it against
Apple's validation schema.  Being written in ruby this can occur off-box to ensure that the utility itself
hasn't been compromised

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'efivalidate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install efivalidate

## Usage

    $ efivalidate

    Usage: efivalidate {input.bin} [PARAMS]

      {input.bin} is a EFI payload saved using either `eficheck` or `BootRomFlash.efi`

      --download-signatures

          Attempts to download Apple's EFI signatures from their update service

      --signatures-path

          Points to a path on disk where known EFI signatures exist


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/dropbox/efivalidate]. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## We need your help!
`efivalidate` is under active development! As you can see from the API docs, we only support a small number of features today and have only scratched the surface of what's possible. We would love feedback from you, our users, to guide what to build next and how to improve the tool.

So please, file feature requests, report bugs or better yet, send us pull requests! More on contributing below.

## Contributing
Step 1: If you're submitting a non-trivial change, please fill out the [Dropbox Contributor License Agreement](https://opensource.dropbox.com/cla/) first.
Step 2: send a [pull request](https://help.github.com/articles/using-pull-requests/)
Step 3: Profit!
