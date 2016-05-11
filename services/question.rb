module Service
  class Question
    attr_accessor :title, :options, :correct_indexes

    def initialize
      @title = ''
      @options = []
    end

    def to_gift_str
      buf = "#{ escape_gift_chars @title } {\n"

      @options.each do |current_option|
        if current_option[:correct]
          buf << '='
        else
          buf << '~'
        end
          buf << "#{ escape_gift_chars(current_option[:body]) }\n"
      end

      buf << "}\n\n"
      buf
    end

    def escape_gift_chars(str)
      pattern = /[#=~\{\}\/\/:\[\]]|\../
      str.gsub(pattern) { |match| '\\' + match }
    end
  end
end
