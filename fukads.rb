require "httparty"

def root?
	return `id -u`.chomp == "0"
end

def build_hosts
	dir = File.dirname(__FILE__)
	hosts_tmp = File.open("/tmp/fukads-hosts" ,"w+")

	File.read("#{dir}/sources.txt").each_line do |source|
		source.strip!
		puts "Retrieving entries from #{source}"
		response = HTTParty.get(source)
		hosts_tmp.write(response.body)
		hosts_tmp.write("\n")
	end
end

def append_original
	hosts_tmp = File.open("/tmp/fukads-hosts" ,"a")
	if File.exist? "/etc/hosts-original" then
		hosts_original = File.read("/etc/hosts-original")
	else
		hosts_original = File.read("/etc/hosts")
	end
	hosts_tmp.write(hosts_original)
end

def copy_to_system
	system "cp /etc/hosts /etc/hosts-original" if !File.exist? "/etc/hosts-original"
	system "cp /tmp/fukads-hosts /etc/hosts"
end

def install
	puts "Building hosts file"
	build_hosts
	puts "Appending original hosts file"
	append_original
	puts "Copying hosts file to system"
	copy_to_system
end

def restore
	system "cp /etc/hosts-original /etc/hosts" if File.exist? "/etc/hosts-original"
end

if root?
	case ARGV[0]
	when "install"
		puts "Installing Fukads"
		install
	when "uninstall"
		puts "Restoring original hosts file"
		restore
	else
		puts "Usage:
install - install fukads to /etc/hosts
uninstall - restore the original /etc/hosts"
	end
else
	puts "Must be run as root!"
end