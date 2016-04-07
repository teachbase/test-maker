require './service'

Cuba.plugin Service
Cuba.plugin Cuba::Render

Cuba.settings[:render][:template_engine] = "haml"
Cuba.settings[:render][:views] = "./views"

Cuba.define do
  on get do
    on "new" do
      on root do
        render :new
      end
    end

    on "sess" do
      res.write session[:message]
    end

    on root do
      session[:message] = "Redirected"
      res.redirect "new"
    end
  end

  on post do
    on root do
      on param(:quiz) do |quiz|
        set_quiz_options(quiz)

        questions = convert(quiz["body"], question_prefix: quiz["question_prefix"],
                                          option_prefix: quiz["option_prefix"],
                                          option_correct: quiz["option_correct"])

        set_path(quiz["theme"]) if session[:filename].nil? || !File.exist?(session[:filename])

        write_result(questions)

        res.write partial :quiz_preview, questions: questions
      end
    end

    on true do
      res.write "Error"
    end
  end
end
