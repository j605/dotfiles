require 'rake'
require 'fileutils'
require 'yaml'

HOME = ENV['HOME']
DOTDIR = "#{HOME}/dotfiles"

desc 'Do the best.'
task :install => [
  :init_submodules,
  :update_submodules,
  :brew,
  :update_injection,
  :deploy ] do
end

desc 'Deploy dotfiles.'
task :deploy do
  directories = YAML.load_file('config/directory_structure.yml')
  dotfiles = YAML.load_file('config/dotfiles.yml')
  Dir.chdir(HOME) do
    mkdir_hierarchy(directories)
  end
  Dir.chdir(DOTDIR) do
    deploy_dotfiles(dotfiles)
  end
end

desc 'Update submodules'
task :update_submodules do
  run %{
    git submodule update --recursive
  }
end

task :init_submodules do
  run %{ git submodule update --init --recursive }
end

task :brew do
  %w(
    git
    hub
    tig
    vim
    zsh
    tmux
    coreutils
    the_silver_searcher
    bzr
    aspell
    fasd
    direnv
  ).each do |software|
    run %{ brew install #{software} }
  end
end

desc 'Update files with injection of other files'
task :update_injection do
  files_with_injection = run %{
    ag --files-with-matches 'INJECT_START' --ignore 'Rakefile' --ignore 'bin/inject'
  }
  files_with_injection.split.each do |fname|
    run %{ #{DOTDIR}/bin/inject #{fname} }
  end
end

desc 'Doctor'
task :doctor do
  if ENV['MY_NAME'].nil?
    puts 'Your ~/.envrc is not allowed. Try `direnv allow`.'
  end
end

desc 'Mac settings'
task :mac do
  puts "Deploying plist files"
  Dir.glob("#{DOTDIR}/macfiles/LaunchAgents/*") do |plist|
    fname = File.basename(plist)
    my_ln(plist, "#{HOME}/Library/LaunchAgents/#{fname}")
  end
end

task :generate_global_tags do
  run %{
    ctags \
      -R \
      -f ~/tags_ruby \
      --sort=yes \
      --exclude=*.js \
      --exclude=*.h \
      --exclude=log \
      --exclude=*.yml \
      --exclude=.git \
      --langmap=RUBY:.rb \
      $rvm_path/rubies/default

    ctags \
      -R \
      -f ~/tags_gem \
      --sort=yes \
      --exclude=*.js \
      --exclude=*.exp \
      --exclude=*.am \
      --exclude=*.in \
      --exclude=*.m4 \
      --exclude=*.o \
      --exclude=*.h \
      --exclude=log \
      --exclude=*.yml \
      --exclude=.git \
      --langmap=RUBY:.rb \
      $GEM_HOME/gems
  }
end

private

def run(cmd)
  puts "[Running] #{cmd} (#{Dir.pwd})"
  `#{cmd}` unless ENV['DEBUG']
end

def mkdir_hierarchy(obj)
  case obj
  when String
    run %{ mkdir -p #{obj} }
  when Array
    obj.each{ |o| mkdir_hierarchy(o) }
  when Hash
    obj.each do |k, v|
      run %{ mkdir -p #{k} }
      Dir.chdir(k) do
        mkdir_hierarchy(v)
      end
    end
  end
end

def deploy_dotfiles(obj)
  case obj
  when String
    my_ln("#{Dir.pwd}/#{obj}", "#{HOME}/.#{obj}")
  when Array
    obj.each{ |o| deploy_dotfiles(o) }
  when Hash
    obj.each do |k, v|
      Dir.chdir(k) do
        deploy_dotfiles(v)
      end
    end
  end
end

def my_ln(src, dst)
  run %{ rm #{dst} } if File.symlink?(dst)
  raise %{File "#{dst}" exists and not a symlink.} if File.exists?(dst)
  dir = File.dirname(dst)
  FileUtils.mkdir_p(dir) unless File.directory?(dir)
  run %{ ln -s #{src} #{dst} }
end

# OS check (http://stackoverflow.com/questions/170956/how-can-i-find-which-operating-system-my-ruby-program-is-running-on)
module OS
  def OS.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
   (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
    !OS.windows?
  end

  def OS.linux?
    OS.unix? and not OS.mac?
  end
end
