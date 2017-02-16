class Qna < ActiveRecord::Base
  belongs_to :user
  self.per_page = 5

  def is_answered?
    return self.answer.present?
  end

  def status
    if self.is_answered?
      return "답변완료"
    else
      return "대기중"
    end
  end
end
