

class BlogPostsController < ApplicationController

 

 before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
 
 def index
   #collection of all the instances of BlogPost in your database
   @blog_posts = BlogPost.all
 end

 def show
    @comment = Comment.new
 end

 def edit
 end


 def new
   #Creating a new instance of BlogPost(initialize from ruby classes)
   @blog_post = BlogPost.new
 end

 def create
   #(blog_post_params)Method we will set next step in the private section where we allow all the BlogPosts attributes.
   @blog_post = BlogPost.new(blog_post_params)

   respond_to do |format|
   if @blog_post.save #Method from BlogPost Class// #Route(@blog_post) when BlogPost saves to DB
     format.html {redirect_to blog_post_url(@blog_post), notice:
       "Blog Post was created successfully."}
     else
       #'render' to new blog post page when blog post can't be saved to DB.
       format.html {render :new}
     end
   end

 end

 def update
   respond_to do |format|
     #Method(blog_post_params)from the BlogPost Class
     if @blog_post.update(blog_post_params)
     #Route(@blog_post) when BlogPost saves to DB
      format.html { redirect_to blog_post_url(@blog_post), notice:
       "Blog post was updated successfully!"}
      else
       #render to edit blog post when blog post can't be updated.
       format.html { render :edit}
      end
  end
 end

 def destroy
   #Method from blog post class
   @blog_post.destroy

   respond_to do |format|
     #Route to when a blog post is destroyed. Could have set instead also root_url because BlogPost index view is the root page.
     format.html { redirect_to blog_posts_url, notice:
       "Your blog was destroyed!"}
     end
   end


   private
   #This method looks for just one instance of the BlogPosts
   #(Using the ID#) Will be used in before_action on top
   #to load a certain BlogPost before the show, edit, update &
   #destroy method is executed in the controller.
   def set_blog_post
     @blog_post = BlogPost.find(params[:id])
   end
   #Method used on the "create" & "update" metgod to give
   #access to all attributes. Without this method the attributes
   #would be still empty in the database when we create or update a BlogPost.
   def blog_post_params
     params.require(:blog_post).permit(:title, :blog_entry, :author)
   end


end