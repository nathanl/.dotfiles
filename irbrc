#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'
# 
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

IRB.conf[:PROMPT_MODE] = :SIMPLE

require "rubygems"

def copy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end

def copy_history
  history = Readline::HISTORY.entries
  index = history.rindex("exit") || -1
  content = history[(index+1)..-2].join("\n")
  puts content
  copy content
end

def paste
  `pbpaste`
end

def avg(*arr)
  arr = arr.flatten
  arr.reduce(&:+) / Float(arr.length)
end

class Object
  def method_ancestry(method_name)
    method_ancestors = []
    method = method(method_name)
    while method
      method_ancestors << [method.owner, method.source_location]
      method = method.super_method
    end
    method_ancestors
  end
end
