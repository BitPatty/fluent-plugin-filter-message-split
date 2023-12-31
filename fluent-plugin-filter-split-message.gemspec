lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = "fluent-plugin-filter-split-message"
  spec.version = "0.1.0"
  spec.authors = ["Matteias Collet"]
  spec.email = ["matteias.collet@protonmail.ch"]

  spec.summary = %q{Message splitter filter for Fluentd}
  spec.description = spec.summary
  spec.homepage = "https://github.com/bitpatty/fluent-plugin-filter-split-message"
  spec.license = "MIT"

  test_files, files = `git ls-files -z`.split("\x0").partition do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.files = files
  spec.executables = files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = test_files
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "test-unit", "~> 3.3"
  spec.add_runtime_dependency "fluentd", ">= 1"
end
