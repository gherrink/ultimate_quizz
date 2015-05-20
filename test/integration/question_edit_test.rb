require 'test_helper'

class QuestionEditTest < ActionDispatch::IntegrationTest
  def setup
    @creator = users(:creator)
    @question = questions(:question_one)
    @category = categories(:category)
  end

  test "unsuccessful edit" do
    log_in_as(@creator)
    get edit_question_path(@question)
    assert_template 'questions/edit'
    patch question_path(@question), question: {
      answer_correct: "a",
      answer_wrong_1: "b",
      answer_wrong_2: "c",
      answer_wrong_3: "d",
      rating: 0,
      question: "Is this a question?",
      category_ids: [@category.id]
    }
    assert_template 'questions/edit'
  end
end
