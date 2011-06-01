$:.unshift(File.dirname(__FILE__))

require 'redcarpet'
require 'tempfile'

module Redcarpeter

  class << self
    def version
      @version ||= File.read(File.join(File.dirname(__FILE__), '..', 'VERSION')).chomp
    end
  end
  VERSION = self.version
  
  class Base
    attr_reader :args, :input, :filename, :extension

    def initialize *args
      @args = args.flatten

      @input = @args.first

      @extension = File.extname(@input)
      @filename = File.basename(@input, @extension)
    end

    class << self
      def compile *args
        new(args).compile!
      end
    end

    def markdown
      @markdown ||= Redcarpet.new(File.read(@input))
    end

    def compile!
      File.open("#{filename}.html", 'w') do |file| 
        file.write(markdown.to_html)
      end
    end
  end

end