#!/usr/bin/env ruby
require_relative 'bootstrap'
require 'thor'

class MediaSort < Thor
  desc 'Organise', "Rename media files with correct names"
  def organise_movies(location, recursive=false)
    filemagic = FileMagic.new()

    Dir.chdir location
    files = Dir['./*']

    files.each do |file|
      puts filemagic.file(file)
    end
    
  end
end
