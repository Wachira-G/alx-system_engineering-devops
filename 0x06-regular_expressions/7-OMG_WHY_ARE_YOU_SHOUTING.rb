#!/usr/bin/env ruby
# This script contains a regular expression
# that must be only matching: capital letters

puts ARGV[0].scan(/[A-Z]/).join
