require 'thor'
require 'pathname'
require 'fileutils'

module Genny
  # The genny commnad line application
  #
  # Uses Thor to map methods to subcommands and handle all the boring clie stuff
  # @see http://whatisthor.com/
  class Cli < Thor
    desc 'new TEMPLATE DESTINATION',
         'Generate a template at the given destination'
    def new(template, destination)
      dest_dir = Pathname.new(destination).expand_path
      dest_dir.mkpath

      template_dir = templates_root + template
      files = file_list template_dir
      files.each do |file|
        relative_file = file.relative_path_from template_dir
        (dest_dir + relative_file.dirname).mkpath
        cp template_dir + file, dest_dir + relative_file
      end
    end

    private

    def cp(from, to)
      FileUtils.cp from.to_s, to.to_s
    end

    def file_list(root)
      root.children.flat_map do |child|
        if child.directory?
          file_list(child)
        else
          child
        end
      end
    end

    def templates_root
      Pathname.new('~/.genny/templates').expand_path
    end
  end
end
