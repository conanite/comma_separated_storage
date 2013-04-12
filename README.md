# CommaSeparatedStorage

Given an object with a string attribute containing a comma-separated list of items,
this gem makes it easier to deal with the list even though it is stored as a string

## Installation

Add this line to your application's Gemfile:

    gem 'comma_separated_storage'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install comma_separated_storage

## Usage

    class Widget
      extend CommaSeparatedStorage
      attr_accessor :languages
      comma_separated_storage :languages, :interrogate => :speaks?
    end

    widget = Widget.new
    widget.languages = "de,jp,it"

    widget.language_list      # => ["de", "jp", "it"]
    widget.default_language   # => "de"

    widget.speaks? "de"       # => "de"
    widget.speaks? "en"       # => false

    list = []
    widget.each_language { |x|
      list << x
    }
    list                      # => ["de", "jp", "it"]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Authors

[Conan Dalton](http://www.conandalton.net)
