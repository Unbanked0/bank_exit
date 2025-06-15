class CommentDecorator < ApplicationDecorator
  def flagged?
    flag_reason.present?
  end
end
