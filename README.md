# Audio Fingerprint Modeling Toolkit



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'afm_toolkit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install afm_toolkit

## Usage

#### Creating a new workspace

`Workspace.create("/path/to/workspaces/my_collection", "my_collection")`

#### Loading an existing workspace and adding an audio source file

```ruby
workspace = Workspace.load("/path/to/workspaces/my_collection")
workspace.add_audio("path/to/source.wav", "audio_label")
```

#### Creating a degradated version
```ruby
workspace = Workspace.load("/path/to/workspaces/my_collection")
my_audio = workspace.audios.first
pitched_audio = my_audio.create_degradated_version("pitched_3s", "pitch", {semitones: 3})
```


#### Processing onsets
```ruby
my_audio.process_onsets("hfc_default", "hfc", {})
my_audio.process_onsets("energy_default", "energy", {})

pitched_audio.process_onsets("hfc_default", "hfc", {})
pitched_audio.process_onsets("energy_default", "energy", {})

```

#### Comparing detected onsets in the same file
```ruby
onsets1 = my_audio.onsets["hfc_default"]
onsets2 = a2.onsets["hfc_default"]


# Comparing onsets
Analyzers::OnsetMatcher.new(onsets1, onsets2).run(25).stats


# Comparing onsets ovr time-relative values
v1 = onsets1.relative_values
v2 = onsets2.relative_values
Analyzers::OnsetMatcher.new(v1, v2).run(25).stats

```

#### Persisting collected information
```ruby
my_audio.dump

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/arthurtofani/afm_toolkit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AfmToolkit project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/afm_toolkit/blob/master/CODE_OF_CONDUCT.md).
