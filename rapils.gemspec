$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'rapils/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name = 'rapils'
  spec.version = Rapils::VERSION
  spec.authors = [
    'Marc Qualie'
  ]
  spec.email = [
    'marc@marcqualie.com'
  ]
  spec.homepage = 'https://github.com/signisto/rapils'
  spec.summary = 'Opinionated out-of-the-box API + UI framework'
  spec.description = 'Opinionated out-of-the-box API + UI framework'
  spec.license = 'MIT'

  spec.files = Dir[
    '{app,config,db,lib}/**/*',
    'MIT-LICENSE',
    'Rakefile',
    'README.md',
  ]

  spec.add_dependency 'rails', '~> 6.0.3', '>= 6.0.3.1'
end
