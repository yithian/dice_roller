require 'rubygems/package_task'

task :default => [:gem]

spec = Gem::Specification.new do |s|
  s.name          = 'dice_roller'
  s.summary       = 'a dice roller for games'
  s.description   = <<-EOF
    dice_roller is a pure ruby application that rolls dice for role playing games.
    it is primarily built to handle d20 or Storytelling style rolls.
  EOF
  s.version       = '0.0.4'
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Alex Chvatal']
  s.email         = ['m.chvatal@gmail.com']
  s.homepage      = 'https://github.com/yithian/dice_roller'
  s.license       = 'GPL'
  s.require_path  = 'lib'
  s.files         = Dir['lib/**/*.rb'] + Dir['bin/*']
  s.executables   = ["dice_roller"]
end

Gem::PackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end

desc "run the test suite"
task :test do
  Dir.glob('test/*').each do |file|
    ruby file
  end
end
