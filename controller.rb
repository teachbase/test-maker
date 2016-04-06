require './service'

Cuba.plugin Service

Cuba.define do
  on get do
    on "new" do
      on root do
        render :new
      end
    end

    on "test" do
      res.write "Ajax done"
    end
  end

  on post do
    on root do
      on param(:quiz) do |quiz|
        quiz["theme"] = "result_#{Time.now.strftime("%Y_%m_%d-%H_%M_%S")}" if quiz["theme"] == ""
        quiz["option_correct"] = "+|*" if quiz["option_correct"] == ""
        quiz["option_correct"] = to_suffix quiz["option_correct"]

        questions = convert(quiz["body"], question_prefix: quiz["question_prefix"],
                                          option_prefix: quiz["option_prefix"],
                                          option_correct: quiz["option_correct"])
        path = "/upload/#{quiz["theme"]}.txt"
        result = File.open("public#{path}", "w")
        questions.each do |question|
          question.write result
        end
        result.close

        render :quiz_preview, questions: questions, filename: path
      end
    end

    on true do
      res.write "Error"
    end
  end
end
