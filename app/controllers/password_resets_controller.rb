class PasswordResetsController < ApplicationController
=begin
  before_filter :require_no_user

  def new
    render
  end  

  def create  
    @user = User.find_by_email(params[:email])  
    if @user  
      @user.deliver_password_reset_instructions!  
      flash[:notice] = "Instructions to reset your password have been emailed to you. " +  "Please check your email."  
      redirect_to root_url  
    else  
      flash[:notice] = "No user was found with that email address"  
      render :action => :new  
    end  
  end  

  def edit
   render 
  end

  def update
    @user.password = params[:person][:password]
    @person.password_confirmation = params[:person][:password_confirmation]
    if @person.save
      flash[:notice] = "密码设置成功！"
      redirect_to login_path
    else
      render :action => :edit
    end
  end

  private
  def load_user_using_perishable_token
    @person = Person.find_using_perishable_token(params[:id])
    unless @person
      flash[:notice] = "很抱歉，但我们无法找到您的帐户. " +
        "如果您有问题, 可以再从您的电子邮件复制网址并粘贴到浏览器 " +
        "或重新启动重置密码的过程."
      redirect_to login_path
    end
  end
=end

  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
#  before_filter :require_no_user
  
  def new
    render
  end
  
  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = "Instructions to reset your password have been emailed to you. " +
        "Please check your email."
      redirect_to root_url
    else
      flash[:notice] = "No user was found with that email address"
      render :action => :new
    end
  end
  
  def edit
    render
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = "Password successfully updated"
      redirect_to login_url
    else
      render :action => :edit
    end
  end

  private
    def load_user_using_perishable_token
      @user = User.find_using_perishable_token(params[:id])
      unless @user
        flash[:notice] = "We're sorry, but we could not locate your account." +
          "If you are having issues try copying and pasting the URL " +
          "from your email into your browser or restarting the " +
          "reset password process."
        redirect_to root_url
      end
    end

end
