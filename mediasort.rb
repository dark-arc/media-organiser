#!/usr/bin/env ruby
require_relative 'bootstrap'
require 'thor'
require 'ruby-filemagic'

class MediaSort < Thor
  desc 'organise', "Rename media files with correct names"
  def organise_movies(location, recursive=false)
    filemagic = FileMagic.new(FileMagic::MAGIC_MIME)
    api = API::OMDB.new

    files = Dir[location]

    files.each do |file|
      next unless filemagic.file(file) =~ /video/
      basename = normalise_filename(File.basename(file, '.*'))

      loop do 
        result = api.search(basename)
        
        if(result['Response'] == 'True')
          puts "Found"
          break
        else
          puts "No results for #{file}"
          print "Title ([c]ancel):"
          basename = STDIN.gets
          break if basename = 'c'
        end
      end
    end
  end

  no_commands do
    def normalise_filename(filename)
      filename = filename.downcase
      filename = filename.gsub /(\W)/, ' '
      filename = filename.gsub /\b(x264|(1080|720)[ip]|(br|hd|tv|cd)rip)\b/, ' '
      filename = filename.gsub /\b(yify|bluray|eng|hin)\b/, ' '
      filename = filename.gsub /\b(hd|ts|cpg)\b/, ' '
      filename = filename.gsub /\b(of|the|in|are|for)\b/, ' '
      filename = filename.lstrip.rstrip.gsub /\s+/, ' '
    end
  end
end

MediaSort.start(ARGV)
