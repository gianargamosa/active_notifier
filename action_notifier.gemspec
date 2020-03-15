require_relative 'lib/action_notifier/version'

Gem::Specification.new do |spec|
  spec.name          = "action_notifier"
  spec.version       = ActionNotifier::VERSION
  spec.authors       = ["Arman Gian Argamosa"]
  spec.email         = ["argamosa.gian@gmail.com"]

  spec.summary       = "It's a framework for dealing with notifying user through in browser notification or native notifications"
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/gianargamosa/action_notifier"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "actionpack", "~> 5.0"
  spec.add_development_dependency "bundler", "~> 1.17.1"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rails", ">= 5.0.0.1", "< 5.2"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "mocha"
end

