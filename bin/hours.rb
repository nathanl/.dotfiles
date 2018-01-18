#!/usr/bin/env ruby
require 'time'
require 'csv'
require 'optparse'

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = "Usage: ruby hours.rb [options]"

  opts.on('--between start,end', Array, "Date range (eg '2013-01-31,2013-02-28')") do |date_range|
    unless date_range.length == 2
      puts "Must provide both start and end dates and nothing more"
      exit 1
    end
    options[:start_date], options[:end_date] = date_range.map { |date_string| Date.parse(date_string.strip) }
  end

  opts.on('--current [timeperiod]', "'week' for this week, 'month' for this month; default is 'week'") do |time_period| 
    time_period ||= 'week'
    unless %w[week month year].include?(time_period)
      puts "Whoops! `--current` must be week, month or year."
      exit 1
    end
    options[:current] = time_period
  end

  opts.on('--v', '--verbose', 'Show every chunk of hours') do |verbose|
    options[:verbose] = true
  end
end
option_parser.parse!

if options.empty?
  puts option_parser
  exit
end

class DateRange
  attr_accessor :start_date, :end_date
  def self.week_of(date)
    week_start = date - (date.wday - 1)
    week_end   = date + (7 - date.wday)
    new(week_start, week_end)
  end
  def initialize(start_date, end_date)
    self.start_date = start_date
    self.end_date   = end_date
  end
  def include?(date)
    date >= start_date && date <= end_date
  end
  def to_s
    "#{start_date.to_s} to #{end_date.to_s}"
  end
end

class TimeFormatter
  attr_accessor :minutes
  def initialize(minutes)
    self.minutes = minutes
  end
  def to_s
    "#{minutes} minutes (#{(minutes / 60.0).floor} hours, #{minutes.remainder(60)} minutes)"
  end
end

def parse_timestamp(timestamp)
  DateTime.strptime(timestamp.strip, "%Y-%m-%dT%H:%M").to_time.localtime
end

today = Date.today
date_range = (
  if options[:start_date] && options[:end_date]
    DateRange.new(options[:start_date], options[:end_date])
  else
    case options[:current]
    when 'year'  then DateRange.new(Date.new(today.year, 1, 1), Date.new(today.year, 12, 31))
    when 'month' then DateRange.new(Date.new(today.year, today.month, 1), Date.new(today.year, today.month, -1))
    when 'week'  then DateRange.week_of(today)
    end
  end
  )

puts "\nReporting hours for #{date_range}\n"
puts "\n*Details*\n" if options[:verbose]

weekly_breakdown = Hash.new {|hash, key| hash[key] = Hash.new(0) }
total_minutes = 0
csv = CSV.new(File.open('billable_hours.csv'), headers: true, skip_lines: /^[#\s]/, skip_blanks: true)
csv.each_with_index do |row, i|
  raise "incomplete line (#{i}): #{row.inspect}" if row.fields.any? {|field| field.nil? || (/\A\s*\z/).match(field)}
  row.map { |key, value| value.strip! }


  start_time = parse_timestamp(row.fetch("start"))
  end_time = parse_timestamp(row.fetch("end"))
  date = start_time.to_date
  next unless date_range.include?(date)

  minutes_worked = ((end_time - start_time) / 60).floor

  week_string = DateRange.week_of(date).to_s
  weekly_breakdown[week_string][date.to_s] += minutes_worked

  if options[:verbose]
    puts "#{date} - #{row['start'].ljust(8, ' ')} to #{row['end'].ljust(8, ' ')} - #{TimeFormatter.new(minutes_worked)}"
  end

  total_minutes += minutes_worked
end

puts "\n*Summaries*\n"

weekly_breakdown.each do |week, days|
  puts week
  week_total = 0
  days.each do |day, minutes|
    puts "  #{day} - #{TimeFormatter.new(minutes)}"
    week_total += minutes
  end
  puts "  Week total: #{TimeFormatter.new(week_total)}\n"
end

puts "\nGRAND TOTAL: #{TimeFormatter.new(total_minutes)}"
