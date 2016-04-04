module Service
  class Converter
    attr_accessor :current_question

    def self.convert(strings, question_prefix: '^\s*\d+\.', option_prefix: '^\s*.+?\.', option_correct: '(\+|\*?)')
      # init RegExps
      question_regexp = Regexp.new question_prefix + '\s*(.+?)\:?\s*$'
      option_regexp = Regexp.new option_prefix + '\s*(.+?)' + option_correct + '\s*$'

      # skipping frist lines if they aren't questions
      current_string = strings.shift
      until current_string =~ question_regexp do
        current_string = strings.shift
      end

      result = []

      loop do
        # finish if EOF
        result << @current_question if current_string.nil? && !@current_question.nil?
        break if current_string.nil?
        current_string = current_string.chomp.sub("\xEF\xBB\xBF", "")

        if current_string =~ question_regexp # new question
          result << @current_question unless @current_question.nil?

          @current_question = Question.new

          @current_question.title = $1
        elsif current_string =~ option_regexp # add option
          @current_question.options.push(body: $1, correct: !($2 == ''))
        elsif current_string =~ /^\s*$/ # empty line
          current_string = strings.shift
          next
        elsif current_string =~ /\s*(.+?)\:?\s*$/ # multiline question
          @current_question.title = @current_question.title + " #{$1}"
        end

        current_string = strings.shift # in the end because when enter loop already have string
      end

      @current_question = nil
      result
    end
  end
end
