require 'pathname'

def templates_root
  Pathname.new('~/.genny/templates').expand_path
end

def make_template(name, files = {})
  root = templates_root + name
  root.mkpath

  files.each do |file, contents|
    path = root + file.to_s
    path.dirname.mkpath
    path.open('w') do |f|
      f.write contents.to_s
    end
  end
end
