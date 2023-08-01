#!/usr/bin/env ruby
# This Ruby script accepts one argument
# and passes it to a regular expression matching method
# The regular expression will match the cases "hbttn, hbtttn, hbttttn, hbtttttn" (2-5 t's)

puts ARGV[0].scan(/hbt{2,5}n/).join
