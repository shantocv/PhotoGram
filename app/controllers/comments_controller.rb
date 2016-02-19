class CommentsController < ApplicationController
	before_action :find_post

	def create
		@comment = @post.comments.create(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end			
			# flash[:success] = "Your Comment Has been posted"
			# redirect_to :back
		else
			flash[:alert] = "Something went Wrong. Please Try again"
			render root_path
		end
	end

	def destroy
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		# flash[:success] = 'Comment Deleted'
		# redirect_to :back
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end			
	end

	private

	def comment_params
		params.require(:comment).permit(:content)
	end

	def find_post
		@post = Post.find(params[:post_id])
	end

end
