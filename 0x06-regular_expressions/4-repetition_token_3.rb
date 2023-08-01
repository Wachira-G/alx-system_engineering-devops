#!/usr/bin/env ruby
# This Ruby script accepts one argument
# and passes it to a regular expression matching method
# The regular expression will match the cases where the argument has no 'o'

puts ARGV[0].scan(/hbo{0}t{0,}n/).join
