module Service
  class Converter
    attr_accessor :current_question

    def self.convert(strings, option_prefix: '^\s*[^\d\s]\.', option_correct: '(\+|\*?)')
      # init RegExps
      # question_regexp = Regexp.new question_prefix + '\s*(.+?)\:?\s*$'
      question_regexp = /^\s*\d+(\.|\))\s*(.+?)\s*$/
      option_regexp = Regexp.new option_prefix + '\s*(.+?)' + option_correct + '\s*$'

      result = []
      @last_parse = "opt"

      loop do
        current_string = strings.shift

        # finish if EOF
        result << @current_question if current_string.nil? && !@current_question.nil?
        break if current_string.nil?
        current_string = current_string.chomp.sub("\xEF\xBB\xBF", "")

        if current_string =~ /^\s*$/ # empty line
          next
        elsif current_string =~ option_regexp # add option
          @current_question.options.push(body: $1, correct: !($2 == ''))
          @last_parse = "opt"
        else
          if @last_parse == "opt" # new question
            result << @current_question unless @current_question.nil?

            @current_question = Question.new
            if current_string =~ question_regexp
              @current_question.title = $2
            else
              @current_question.title = current_string
            end

            @last_parse = ""
          else # multiline question
            @current_question.title += " " + current_string
          end
        end
      end

      @current_question = nil
      result
    end
  end
end
