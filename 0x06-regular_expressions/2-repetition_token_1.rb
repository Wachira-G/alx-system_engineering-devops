#!/usr/bin/env ruby
# This Ruby script accepts one argument
# and passes it to a regular expression matching method
# The regular expression will match the cases htn and hbtn
# and not hbbtn nor hbbbtn

puts ARGV[0].scan(/hb?tn/).join
