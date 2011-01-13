# Puppet-watch

## **Automatic syntax checking for your puppet manifests, instant notifications to your desktop using libnotify*

* **Puppet-Watch** is a ruby script that watches if there is any changes to your puppet manifests (by monitoring .pp files) and sends notifications to your desktop if the puppet manifest you just created/edited passes the syntax checks or not.
* It aims to facilitate the development of puppet code by sending instant notifications to your Ubuntu Desktop 

### Installation (Ubuntu)

1. ``` sudo apt-get install g++ ruby1.8-dev  libnotify-bin```
2. ``` sudo gem install eventmachine  em-dir-watcher rb-inotify```
3. Edit the "dir" variable in puppet-watch.rb with the full path of your puppet manifests.
4. Run the script: ``` ruby puppet-watch.rb```

### TODO
* Based on AhmedElGamil https://github.com/AhmedElGamil/puppet-growl/blob/master/README.md

