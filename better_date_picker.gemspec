# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'better_date_picker/version'

Gem::Specification.new do |spec|
  spec.name          = "better_date_picker"
  spec.version       = BetterDatePicker::VERSION
  spec.authors       = ["Dan Pickett"]
  spec.email         = ["dan.pickett@launchware.com"]
  spec.description   = %q{Assign Dates with Chronic Strings}
  spec.summary       = %q{Use Chronic Strings to Assign Dates}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel"
  spec.add_dependency "activesupport"
  spec.add_dependency "chronic"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
