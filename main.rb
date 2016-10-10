#!/usr/bin/env ruby
require_relative 'bootstrap'

def get_response()
  print "[1..9] Rename, [S]kip: "
  res = gets
  if(res =~ /^[0-9]*/)
    return :rename
  elsif res =~ /^[SsNn]/
    return :skip
  else
    return :bad_input
  end
end

movie_api = API::OMDB.new

movie_list = Dir['./mount/*'].entries

movie_list.each do |movie|
  next unless File.file? movie
    
  name = File.basename(movie, '.*').split('-').last
  result = movie_api.search(name)
  puts "Results for #{movie}:"

  if result['Response'] == 'True'
    index = 0
    result['Search'].each do |possibility|
      puts " #{index}. #{possibility['Title']} (#{possibility['Year']})"
      index += 1
    end
  else
    puts "None"
    next
  end

  response = :none
  loop do 
    response = get_response
    break unless response == :bad_input
  end
end

