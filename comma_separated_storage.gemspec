# -*- coding: utf-8; mode: ruby  -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'comma_separated_storage/version'

Gem::Specification.new do |gem|
  gem.name          = "comma_separated_storage"
  gem.version       = CommaSeparatedStorage::VERSION
  gem.authors       = ["conanite"]
  gem.email         = ["conan@conandalton.net"]
  gem.description   = %q{Create utility methods to access an attribute as a list but store it as a comma-separated string}
  gem.summary       = %q{Given an object with a string attribute containing a comma-separated list of items,
this gem makes it easier to deal with the list even though it is stored as a string}

  gem.homepage      = "https://github.com/conanite/polyglot"

  gem.add_development_dependency 'rspec', '~> 2.9'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
