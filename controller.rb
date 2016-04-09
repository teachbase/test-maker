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
      session.clear
      res.redirect "new"
    end

    on "error" do
      res.status = 500
    end

    on root do
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
        if questions.nil?
          res.redirect "error"
        else
          set_path(quiz["theme"])
          write_result(questions)
          res.write partial :_quiz_preview, questions: questions
        end
      end
    end

    on true do
      res.redirect "error"
    end
  end

  on delete do
    on root do
      FileUtils.rm_rf File.dirname(session[:filename]) if session[:dirname]
      session.clear
      res.status = 200
    end
  end
end
