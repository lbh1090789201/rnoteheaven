class CommentsController < ApplicationController
  before_action do
    # render js: "window.location.href = '/users/sign_in'" if !current_user
    authenticate_user!
  end

  def create
    comment = Comment.new({
      content: params[:content],
      note_id: params[:id],
      user_id: current_user.id
      })

    if comment.save!
      user = User.find current_user.id
      show_name = user.show_name
      avatar = user.avatar_url ? user.avatar_url : "avator.png"
      @comment = {
        content: comment.content,
        show_name: show_name,
        avatar: avatar
      }

      render json: {
        success: true,
        info: "评论成功！",
        comment: @comment
      }, status: 200
    end
  end
end
