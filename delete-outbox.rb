#!/usr/bin/env ruby

require 'fileutils'

if ARGV.length > 0

	directory = ARGV[0]
	files = Dir.new(directory).entries
	hold_time = Time.new.to_i - 60 * 60 * 24 * 7

	files.each do | file |
		path_to_file = "#{directory}/#{file}"
		mtime = File.mtime(path_to_file).to_i
	
		if mtime < hold_time
			unless file == ".." || file == "."
				puts "delete #{path_to_file}"
				if File.directory?(path_to_file)
					FileUtils.remove_dir path_to_file
				else
					File.delete(path_to_file)	
				end
			end
		else
			unless file == ".." || file == "."
				puts "keep #{path_to_file}"
			end
		end
	end
else
  puts "Call with directory as parameter such as:\nruby delete-outbox.rb /home/me/Downloads/Outbox"
end
