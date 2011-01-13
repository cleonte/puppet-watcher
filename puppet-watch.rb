#!/usr/bin/ruby 
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
 


def puppet_watch dir
  puts "Watching #{dir}"
  EM.run do
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
 end
end

if __FILE__ == $0
   unless ARGV.length == 1
     puts " Please specify the directory to watch"
     puts " Usage: ruby puppet-watch.rb directory_to_watch"
     exit
   end
        directory=ARGV[0]
	puppet_watch "#{directory}"


end
