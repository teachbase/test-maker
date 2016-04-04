module Service
  class Question
    attr_accessor :title, :options, :correct_indexes

    def initialize
      @title = ''
      @options = []
    end

    def write(result)
      result.write "#{ escape_gift_chars @title } {\n"

      @options.each do |current_option|
        if current_option[:correct]
          result.write '='
        else
          result.write '~' + escape_gift_chars(current_option[:body])
        end
        result.write escape_gift_chars(current_option[:body]) + "\n"
      end

      result.write "}\n"
    end

    def escape_gift_chars(str)
      pattern = /[#=~\{\}\/\/:\[\]]|\../
      str.gsub(pattern) { |match| '\\' + match }
    end
  end
end
