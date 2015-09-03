require "ubusetup/version"
require 'net/ping'
require 'thor'
include Net
module Ubusetup
  # Your code goes here...

  class Ubusetup < Thor
    package_name "ubusetup"

    # config method doing some staff but not atomatic to
    # let the user to choose what he needs on his own machine
    desc "config", "setup and prepare system after a new installation"
    long_desc <<-LONGDESC
      #{File.read("./lib/ubusetup/config_desc").gsub("\n", "\n\n")}
    LONGDESC
    def config
      check_connection
      if @pt.ping?
        puts set_color "You can do a lot :\n", :cyan
        puts set_color %Q{Choose any item from the list to start :
            1 => Update My System
            2 => Tweak My System.
            3 => Protect Privacy.
                 [only if you are using ubuntu with Unity-desktop]
            4 => Disable Overlay Scrollbar.
            5 => Show Username on Panel.
            6 => Install Flash Player.
            7 => Install Pipelight.
                  [Silverlight Alternative]
            8 => Compression/Decompression tools.
            9 => Disable System Crash Report.
            10 => Reset Unity.
            q for exit.
          }, :magenta
        item = ask("Enter your choise : ")
        item = item.to_i
        ## second if --- needs end2
        if item.between?(1, 10)
          ## third if --- needs end 3
          case item
          when 1
            puts set_color "[ Updating your system ]", :cyan
            puts set_color " \n=> May takes time depends on your internet speed ", :cyan
            puts set_color "\n-----------------------------------------------------\n", :cyan
            fork { system("sudo apt-get update && sudo apt-get upgrade -y") }
            Process.wait
            $?.to_i
            if $?.exitstatus == 0
              puts set_color "Your system is up to date", :green
            else
              puts set_color "Not updated correctly", :red
            end
          when 2
            puts set_color "Tweaking your Ubuntu ......", :cyan
            puts "----------------------------"
            puts set_color "installing Unity-Tweak-tool and Gnome-Tweak-tool", :cyan
            fork {system("sudo apt-get install unity-tweak-tool gnome-tweak-tool")}
            Process.wait
            $?.to_i
            if $?.exitstatus == 0
              puts set_color "Installing compizconfig-settings-manager ...", :cyan
              fork {system("apt-get install compizconfig-settings-manager")}
              Process.wait
              $?.to_i
              if $?.exitstatus == 0
                puts set_color %Q{Now : Go to Dash and Search "CCSM" >
                Then go to Unity plugin >
                Tick 'Minimize Single Window Applications' feature}, :cyan
              else
                puts set_color "< Compizconfig-setting-manager > did not install correctly ", :red
              end
            else
              puts set_color "Something happened and package could not install well", :red
            end
          else
            puts set_color "Sorry, nothing with this choice ", :red
            # end of case
          end
          # end of if item
        end
        # end of ping
      end
      # End of method < config >
    end

    # private section
    private

    # check_connection check the connection status to the internet
    # will test if google.com is a online or not
    def check_connection
      Ping::TCP.service_check = true
      @pt = Net::Ping::TCP.new("www.google.com")
      puts set_color "Checking Internet Connection.....", :green
      if @pt.ping?
        puts set_color "Internet is working....", :green
        puts set_color "Please use : [ linuxhelper --help ] for more information", :cyan
      else
        puts set_color "Sorry, No internet connection found", :red
      end
      # End of method < check_connection >
    end

    # print_file method will print sll the content of the file with no change
    def print_file(which_file)

      content = File.open(which_file, "r")
      puts content.read
      # End of print_file method
    end


    # End of class < Ubustp >
  end
  Ubusetup.start
#End of module < Ubustp >
end
