class CommentMailerPreview < ActionMailer::Preview
  def send_report_comment
    @merchant = Merchant.take(5).sample
    @comment = @merchant.comments.new(
      id: 123, content: 'Comment spam', flag_reason: :spam
    )

    @description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ut mauris ultricies tellus cursus commodo.'

    CommentMailer
      .with(comment: @comment, description: @description)
      .send_report_comment
  end
end
