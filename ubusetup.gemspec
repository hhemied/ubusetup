# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ubusetup/version'

Gem::Specification.new do |spec|
  spec.name          = "ubusetup"
  spec.version       = Ubusetup::VERSION
  spec.authors       = ["hhemied"]
  spec.email         = ["hazem.hemied@gmail.com"]

  spec.summary       = %q{ubusetup helping Ubuntu users from installation level to the top level.}
  spec.description   = %q{ubusetup is helping Ubuntu users in.
      ==> Setting machines after installing Ubuntu for the daily stable users.
      ==> Using the fastest algorithms to install packages.
      ==> Backing up your installed staff.
      ==> Customized backup algorithm.
      ==> Rescuing Grub in failure cases.}
  spec.homepage      = "https://github.com:hhemied/ubusetup."

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
