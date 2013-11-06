#!/usr/bin/ruby

#require 'rubygems'
require 'fileutils'
require 'pathname'
require 'exifr'

if ARGV.length != 2
	puts "Usage: categorise.rb input_dir output_dir"
	return 1
end

input_dir = ARGV[0].sub(/\/+$/,'')
puts input_dir
output_dir = ARGV[1].sub(/\/+$/,'')
puts output_dir

fpaths = Dir[input_dir + "/*.{jpg,jpeg}"]#.select {|f| !File.directory? f}
fpaths.each do |fpath|
	dir_name = 'other'
	date_time = EXIFR::JPEG.new(fpath).date_time
	if date_time != nil
		dir_name = date_time.strftime('%Y-%m')
	end
	dir_path = output_dir + File::SEPARATOR + dir_name
	FileUtils.mkdir_p(dir_path)

	filename = File.basename(fpath)
	new_fpath = dir_path + File::SEPARATOR + filename
	puts "Copying #{fpath} to #{new_fpath}."
	FileUtils.cp(fpath, new_fpath)
end