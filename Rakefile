require 'fileutils'
require 'debugger'
['pp','yaml'].each { |l| require l }

# Some helpful instance variables.

@home = File.expand_path "~"
@dir = File.expand_path(File.dirname(__FILE__))
@dirs = {
  vim: {
    bundle: File.join(@home, '.vim', 'bundle'),
    autoload: File.join(@home, '.vim', 'autoload'),
    backup: File.join(@home, '.vim', 'backup'),
    scripts: File.join(@home, '.vim', 'scripts'),
    colors: File.join(@home, '.vim', 'colors'),
    syntax: File.join(@home, '.vim', 'syntax'),
  },
  sublime: {
    osx: File.join(@home, 'Library', 'Application Support', 'Sublime Text 2', 'Packages'),
  },
  zsh: {
    scripts: File.join(@home, '.oh-my-zsh', 'custom'),
    themes: File.join(@home, '.oh-my-zsh', 'themes'),
  },
  rbenv: {
    plugins: File.join(@home, '.rbenv', 'plugins'),
  },
  dropbox: {
    root: File.join(@home, 'Dropbox'),
    minecraft: File.join(@home, 'Dropbox', 'Personal', 'Games', 'Minecraft', 'Texture Packs'),
    multimc: File.join(@home, 'Dropbox', 'Personal', 'Games', 'Minecraft'),
  }
}

@urls = {
  pathogen: 'https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim',
  ohmyzsh: 'https://github.com/robbyrussell/oh-my-zsh',
  benlight: 'https://raw.github.com/gist/1481851',
  rbenv: {
    rbenv: 'https://github.com/sstephenson/rbenv',
    rubybuild: 'https://github.com/sstephenson/ruby-build',
  },
}

@syntaxes = {
  jinja: 'http://www.vim.org/scripts/download_script.php?src_id=8666',
  htmljinja: 'http://www.vim.org/scripts/download_script.php?src_id=6961',
}

# Directory setup declarations.

@dirs.each { |top,hash| hash.each { |k,v| directory @dirs[top][k] } }

task default: :all
task all: [:dotfiles, :vim, :zsh]

# Base-level tasks.

desc 'Links all dotfiles into home directory.'
task :dotfiles do
  # Gets all dotfiles in this directory, for each...
  Dir['.*'].find_all{|f|File.file?(f)}.each do |f|
    # ...link_files them into home unless the links already exist.
    link_file File.expand_path(f), File.join(@home, f)
  end
end

# Vim tasks.

desc 'Run all vim tasks.'
task vim: 'vim:all'

namespace :vim do
  task all: [:pathogen, :plugins, :scripts, :colors]

  desc 'Sets up Vim.'
  task pathogen: [@dirs[:vim][:autoload], @dirs[:vim][:backup]] do
    puts "Installing Pathogen."
    destination = File.join(@dirs[:vim][:autoload], 'pathogen.vim')
    `curl -so #{destination} #{@urls[:pathogen]}`
  end

  desc 'Installs or updates all vim plugins from vim.yml.'
  task plugins: @dirs[:vim][:bundle] do
    plugins = load_yaml(File.join(@dir, 'vim.yml'), :plugins)
    Dir.chdir(@dirs[:vim][:bundle])
    plugins.each do |author,repos|
      Array(repos).each do |repo|
        manage_git "https://github.com/#{author}/#{repo}",
                   File.join(@dirs[:vim][:bundle], repo)
      end
    end
  end

  desc 'Installs all scripts from the vim directory.'
  task scripts: @dirs[:vim][:scripts] do
    Dir.chdir File.join(@dir,'vim')
    Dir['*.vim'].each do |f|
      puts "link_fileing custom Vim scripts."
      link_file File.expand_path(f), File.join(@dirs[:vim][:scripts], f)
    end
  end

  desc 'Installs my color scheme(s).'
  task colors: @dirs[:vim][:colors] do
    puts "Installing custom color scheme(s)."
    destination = File.join(@dirs[:vim][:colors], 'benlight.vim')
    `curl -sko #{destination} #{@urls[:benlight]}`
  end

  desc 'Installs more vim syntaxes.'
  task syntax: @dirs[:vim][:syntax] do
    puts "Installing extra Vim syntax files."
    Dir.chdir @dirs[:vim][:syntax]
    @syntaxes.each do |file, syn|
      `curl -sko #{file}.vim #{syn}`
    end
  end
end

desc 'Run all sublime tasks.'
task sublime: 'sublime:all'

namespace :sublime do
  task all: [:plugins, :settings]

  # This is nearly identical to my Vim plugin installer; maybe abstract?
  desc 'Install non-PackageManager plugins.'
  task plugins: @dirs[:sublime][:osx] do
    puts "Cloning extra plugins for Sublime Text 2."
    plugins = load_yaml(File.join(@dir, 'sublime.yml'), :plugins)
    Dir.chdir(@dirs[:sublime][:osx])
    plugins.each do |author, repos|
      Array(repos).each do |repo|
        manage_git "https://github.com/#{author}/#{repo[0]}",
                   File.join(@dirs[:sublime][:osx], repo[1])
      end
    end
  end

  desc 'Symlink sublime settings.'
  task settings: File.join(@dirs[:sublime][:osx], 'User') do
    puts "Symlinking sublime settings files."
    Dir.chdir File.join(@dir, 'sublime')
    Dir['*.sublime-settings','*.sublime-keymap','*.sublime-mousemap','*.sublime-build','*.py'].each do |f|
      link_file File.expand_path(f),
                File.join(@dirs[:sublime][:osx], 'User', f)
    end
  end
end

# Zsh tasks.

desc 'Run all zsh tasks.'
task zsh: 'zsh:all'

namespace :zsh do
  task all: [:ohmyzsh, :scripts, :themes]

  desc 'Install ohmyzsh.'
  task :ohmyzsh do
    puts "Cloning oh-my-zsh."
    manage_git @urls[:ohmyzsh], File.join(@home, '.oh-my-zsh')
  end

  desc 'Install custom zsh scripts.'
  task scripts: @dirs[:zsh][:scripts] do
    puts "Symlinking in custom zsh scripts."
    Dir.chdir File.join(@dir,'zsh')
    Dir['*'].reject { |e| e.match /^\./ }.each do |f|
      link_file File.expand_path(f), File.join(@dirs[:zsh][:scripts], f)
    end
  end

  desc 'Install custom zsh themes.'
  task themes: @dirs[:zsh][:themes] do
    puts "Symlinking in custom zsh themes."
    Dir.chdir File.join(@dir, 'zsh-themes')
    Dir['*'].reject { |e| e.match /^\./ }.each do |f|
      link_file File.expand_path(f), File.join(@dirs[:zsh][:themes], f)
    end
  end
end

# RBENV tasks.

desc 'Run all RBENV tasks.'
task rbenv: 'rbenv:all'

namespace :rbenv do
  task all: [:install, :plugins]

  desc 'Install rbenv.'
  task :install do
    puts "Installing rbenv."
    Dir.chdir(@home)
    manage_git @urls[:rbenv][:rbenv], File.join(@home, '.rbenv')
  end

  desc 'Install rbenv plugins.'
  task :plugins do
    puts "Cloning ruby-build."
    manage_git @urls[:rbenv][:rubybuild], File.join(@home, 'ruby-build')
    puts "Installing ruby-build."
    Dir.chdir(File.join(@home, 'ruby-build'))
    `sh install.sh`
    Dir.chdir(@home)
    puts "Removing temporary ruby-build directory."
    FileUtils.rm_rf 'ruby-build'
  end
end

desc 'Symlinks Dropbox to various places.'
task dropbox: 'dropbox:all'

namespace :dropbox do
  task all: [:minecraft]

  desc 'Symlink texture packs.'
  task :minecraft do
    puts "Symlinking minecraft texture packs."
    destination = File.join(@home, 'Library', 'Application Support', 'minecraft', 'texturepacks')
    debugger
    link_file @dirs[:dropbox][:minecraft], destination
  end

  desc 'Symlink MultiMC instance directory.'
  task :multimc do
    puts "Symlinking minecraft instances."
    base = File.join('/Applications', 'MultiMC.app', 'Contents', 'Resources')
    %w(Instances Mods lwjgl).each do |dir|
      link_file File.join(@dirs[:dropbox][:multimc], dir), File.join(base, dir.downcase)
    end
  end
end

# Some utility functions.

def load_yaml(path, key=nil)
  yml = File.open(path, 'r') { |f| YAML::load f }
  key.nil? ? yml : yml[key.to_s]
end

def link_file(source, destination)
  # Delete the destination file if it exists, otherwise just link_file.
  if File.exists?(destination)
    File.directory?(destination) ? FileUtils.rm_r(destination) : File.delete(destination)
  end
  File.symlink(source, destination)
end

def manage_git(repo, destination)
  # First check if it exists. If it does, do a git pull. Else, clone.
  if File.exists? destination
    puts "Found existing repo at #{destination}. Updating it."
    Dir.chdir(destination)
    `git pull`
    Dir.chdir(File.join(destination, '..'))
  else
    puts "Repo #{repo} not found. Cloning to #{destination}."
    `git clone #{repo} "#{destination}"`
  end
end
