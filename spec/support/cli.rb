require 'genny/cli'

def run_genny(*args)
  Genny::Cli.start args.map(&:to_s)
end
