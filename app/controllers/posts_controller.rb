class PostsController < ApplicationController
  before_filter :require_user, :only => [:new, :edit, :index, :show, :create, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => :create_pic
  
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.where({:implemented => 1})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    @new_comment = @post.comments.build(params[:id])
    
    #debugger
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def new_pic
    @post = Post.new

    respond_to  do |format|
      format.html { render "upload_pic" }
      format.xml { render :xml => @post }
    end
  end

  def create_pic
    @post = current_user.posts.build(params[:id])

    respond_to  do |format|
      if @post.save
        @post.update_attributes(params[:post])
        #format.html { render :json => {:url => edit_post_path(@post), :error => 0} }
        format.html { render :json => edit_post_path(@post) }
      else
        format.html { render :json => '' } # not impletented
      end  
    end
  end


  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = current_user.posts.find(params[:id])
    @post.implemented = 1

    respond_to do |format|
      if @post.update_attributes(params[:post]) && current_user.tag(@post, :with => params[:post][:tag_list], :on => :tags)
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end
