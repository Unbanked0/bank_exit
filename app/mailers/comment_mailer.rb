class CommentMailer < ApplicationMailer
  def send_report_comment
    @comment = params[:comment]
    @description = params[:description]

    @merchant = @comment.commentable.decorate

    # Store a TXT copy version of the mail in backup waiting
    # to have a working SMTP configuration.
    EmailAsTextFile.call(
      'comment_mailer/send_report_comment',
      comment: @comment,
      merchant: @merchant,
      description: @description
    )

    mail
  end
end
