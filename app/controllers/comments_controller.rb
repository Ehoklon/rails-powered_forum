class CommentsController < ApplicationController

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(params[:comment].permit(:comment))
		@comment.user_id = current_user.id if current_user
		@comment.save

		if @comment.save
			redirect_to post_path(@post)
		else
			render 'new'
		end
	end

	def edit 
		if set_comment
			@post = Post.find(params[:post_id])
			@comment = @post.comments.find(params[:id])
		end
	end

	def update
		if set_comment
			@post = Post.find(params[:post_id])
			@comment = @post.comments.find(params[:id])

			if @comment.update(params[:comment].permit(:comment))
				redirect_to post_path(@post)
			else
				render 'edit'
			end
		else
			redirect_to post_path(@post)
		end
	end

	def destroy
		if set_comment
			@post = Post.find(params[:post_id])
			@comment = @post.comments.find(params[:id])
			@comment.destroy
			redirect_to post_path(@post)
		end
	end

	private

	def set_comment
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		current_user.id == @comment.user.id 
	end
end
