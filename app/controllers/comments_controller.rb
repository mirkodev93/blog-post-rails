class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_blog
    before_action :set_comment, only: [:destroy]
    before_action :authorize_comment!, only: [:destroy]

    def create
        @blog = Blog.find(params[:blog_id])
        @comment = @blog.comments.build(comment_params.merge(user: current_user))
        if @comment.save
            redirect_to @blog, notice: "Comment added."
        else
            redirect_to @blog, alert: @comment.errors.full_messages.to_sentence
        end
    end
    
    def destroy
        @blog = Blog.find(params[:blog_id])
        @comment = @blog.comments.find(params[:id])
        @comment.destroy
        redirect_to @blog, notice: "Comment deleted."
    end
    
    private
        def set_blog
            @blog = Blog.find(params[:blog_id])
        end

        def set_comment
            @comment = @blog.comments.find(params[:id])
        end

        def comment_params
            params.require(:comment).permit(:commenter, :body)
        end

        def authorize_comment!
            return if current_user&.admin? || @comment.user_id == current_user&.id
            redirect_to @blog, alert: "Not authorized."
        end
end