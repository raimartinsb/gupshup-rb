# frozen_string_literal: true

#lib = File.expand_path('../lib', __FILE__)
#$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/gupshup-rb/version'

Gem::Specification.new do |spec|
  spec.name = 'gupshup-rb'
  spec.version = Gupshup::VERSION
  spec.authors       = ['Raimundo Martins']
  spec.summary       = 'Communication with Chatwoot - Not Completed! Still does not work!'
  spec.description   = 'Communication with Chatwoot - Not Completed! Still does not work!'
  spec.homepage      = 'https://github.com/raimartinsb/gupshup-rb'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = 'https://github.com/raimartinsb/gupshup-rb'
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(File.expand_path('..', __dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  
  
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency('faraday', '>= 0.9', '< 3.0')
  spec.add_development_dependency 'logger', '~> 1.4.2'


  spec.add_dependency('jwt', '>= 1.5', '< 3.0')
  spec.add_dependency('nokogiri', '>= 1.6', '< 2.0')
  # Workaround for RBX <= 2.2.1, should be fixed in next version
  spec.add_dependency('rubysl') if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'rbx'

  spec.add_development_dependency 'bundler', '>= 1.5', '< 3.0'
  spec.add_development_dependency 'equivalent-xml', '~> 0.6'
  spec.add_development_dependency 'fakeweb', '~> 1.3'
  spec.add_development_dependency 'rack', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'yard', '~> 0.9.9'
end
