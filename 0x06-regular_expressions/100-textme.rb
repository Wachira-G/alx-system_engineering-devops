#!/usr/bin/env ruby
# This exercise was prepared for you by Guillaume Plessis,
# VP of Infrastructure at TextMe. It is something he uses daily.

# For this task, you’ll be taking over Guillaume’s responsibilities:
# one afternoon, a TextMe VoIP Engineer comes to you
# and explains she wants to run some statistics
# on the TextMe app text messages transactions.

# Requirements:

# Your script should output: [SENDER],[RECEIVER],[FLAGS]
# The sender phone number or name (including country code if present)
# The receiver phone number or name (including country code if present)
# The flags that were used
# You can find a [log file here]
# http://intranet-projects-files.s3.amazonaws.com
# /holbertonschool-sysadmin_devops/78/text_messages.log.

puts ARGV[0].scan(/\[from:(.*?)\] \[to:(.*?)\] \[flags:(.*?)\]/).map { |match| match.join(",") }.join("\n")
