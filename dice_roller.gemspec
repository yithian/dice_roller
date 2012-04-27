Gem::Specification.new do |s|
  s.name          = 'dice_roller'
  s.summary       = 'a dice roller for games'
  s.version       = '0.0.1'
  s.date          = '2012-05-26'
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Alex Chvatal']
  s.email         = ['m.chvatal@gmail.com']
  s.require_path  = 'lib'
  s.files         = Dir['lib/**/*.rb'] + Dir['bin/*']
  s.executables   = ["dice_roller"]
end
