#!/usr/bin/env ruby
# This Ruby script accepts one argument
# and passes it to a regular expression matching method
# The regular expression will match the cases "hbtn....hbttn..." (1+ t's)

puts ARGV[0].scan(/hbt+n/).join
