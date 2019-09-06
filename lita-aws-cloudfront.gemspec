Gem::Specification.new do |spec|
  spec.name          = "lita-aws-cloudfront"
  spec.version       = "0.1.0"
  spec.authors       = ["Yuji Ueki"]
  spec.email         = ["unhappychoice@gmail.com"]
  spec.description   = "Lita handler to manage cloud front"
  spec.summary       = "Lita handler to manage cloud front"
  spec.homepage      = "https://github.com/unhappychoice/lita-aws-cloudfront"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.7"
  spec.add_runtime_dependency 'aws-sdk-cloudfront', '~> 1'

  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
  spec.add_development_dependency "rubocop"
end
