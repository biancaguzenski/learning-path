require_relative './hw6provided'
require_relative './hw6assignment'

def runTetris
  Tetris.new 
  mainLoop # this loop allows GUI to show up
end

def runMyTetris
  MyTetris.new
  mainLoop
end

if ARGV.count == 0 # ARGV = command line arguments.
  runMyTetris
elsif ARGV.count != 1 
  puts "usage: hw6runner.rb [enhanced | original]"
elsif ARGV[0] == "enhanced"
  runMyTetris
elsif ARGV[0] == "original"
  runTetris
else
  puts "usage: hw6runner.rb [enhanced | original]"
end
