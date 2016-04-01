module Service
  class Converter
    attr_accessor :current_question

    def self.convert(strings, result, sep: "\n", question_prefix: '^\s*\d+\.', option_prefix: '^\s*.+?\.', option_correct: '(\+|\*?)', answers: nil)
      # init RegExps
      question_regexp = Regexp.new question_prefix + '\s*(.+?)\:?\s*$'
      option_regexp = Regexp.new option_prefix + '\s*(.+?)' + option_correct + '\s*$'

      # skipping frist lines if they aren't questions
      current_string = strings.shift
      until current_string =~ question_regexp do
        current_string = strings.shift
      end

      # open answers file if given
      answers = File.open(answers) unless answers.nil?

      loop do
        # finish if EOF
        @current_question.write(result) if current_string.nil? && !@current_question.nil?
        break if current_string.nil?
        current_string = current_string.chomp.sub("\xEF\xBB\xBF", "")

        if current_string =~ question_regexp # new question
          @current_question.write result unless @current_question.nil?

          @current_question = Question.new

          @current_question.title = $1
          @current_question.correct_indexes = get_correct(answers, sep) unless answers.nil?
          @option_number = 1
        elsif current_string =~ option_regexp # add option
          @current_question.options.push(body: $1, correct: !($2 == '') ||
                                                            @current_question.correct?(@option_number))
          @option_number += 1
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

    def self.get_correct(file, sep)
      file.gets(sep).split(', ').map { |c| c.to_i }
    end
  end
end
