#!/usr/bin/ruby -w
#http://jetpackweb.com/blog/tags/lib-notify/
#https://github.com/AhmedElGamil/puppet-growl
#gem install eventmachine  em-dir-watcher rb-inotify
#apt-get install libnotify-bin

EXPIRATION_IN_SECONDS = 2
ERROR_STOCK_ICON = "gtk-dialog-error"
SUCCESS_STOCK_ICON = "gtk-dialog-info"

require 'rubygems'
require 'em-dir-watcher'

def notify stock_icon, title, message
    options = "-t #{EXPIRATION_IN_SECONDS * 1000} -i #{stock_icon}"
    system "notify-send #{options} '#{title}' '#{message}'"
end
 

dir = "/home/cleonte/work/puppet"

EM.run {
  dw = EMDirWatcher.watch File.expand_path(dir), :include_only => ['*.pp'] do |paths|
    paths.each do |path|
      full_path = File.join(dir, path)
   
      
      result = `puppet --parseonly #{full_path}`.chomp
    

      if result.any?

	notify ERROR_STOCK_ICON, "Puppet", "Syntax Problem, Manifest #{full_path}: #{result}"
	
      else
	notify SUCCESS_STOCK_ICON, "Puppet", "Manifest #{full_path}: Syntax OK"
        
      end      
    end    
  end
}
