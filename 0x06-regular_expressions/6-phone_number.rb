#!/usr/bin/env ruby
# This script contains a regular expression
# that must match a 10 digit phone number

puts ARGV[0].scan(/^\d{10}$/).join
