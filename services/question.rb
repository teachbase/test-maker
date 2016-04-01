module Service
  class Question
    attr_accessor :title, :options, :correct_indexes

    def initialize
      @title = ''
      @options = []
      @correct_indexes = []
    end

    def write(result)
      result << "#{ escape_gift_chars @title } {<br>"

      until @options.empty?
        current_option = @options.shift
        if current_option[:correct]
          current_option[:body] = '=' + escape_gift_chars(current_option[:body])
        else
          current_option[:body] = '~' + escape_gift_chars(current_option[:body])
        end
        result << "#{ current_option[:body] }<br>"
      end

      result << "}<br>"
    end

    def correct?(option_number)
      @correct_indexes.include?(option_number)
    end


    def escape_gift_chars(str)
      pattern = /[#=~\{\}\/\/:\[\]]|\../
      str.gsub(pattern) { |match| '\\' + match }
    end
  end
end
