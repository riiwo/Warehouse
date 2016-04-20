class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :authenticate_worker, :except => [:index, :login, :try_login, :logout]
  before_filter :save_login_state, :only => [:try_login]

  def index

  end
  def login

  end
  def authenticate_worker
    if session[:worker_id]
      @current_user = Worker.where(:id => session[:worker_id]).first
      if @current_user
        @current_user
      else
        redirect_to(:controller => 'application', :action => 'login')
        false
      end
    else
      redirect_to(:controller => 'application', :action => 'login')
      false
    end
  end

  def save_login_state
    if session[:worker_id]
      if Worker.where(:id => session[:worker_id]).first
        redirect_to(:controller => 'application', :action => 'index')
      else
        false
      end
      false
    else
      true
    end
  end

  def logout
    session[:worker_id] = nil
    session[:admin] = nil
    redirect_to :action => 'login'
  end


  def try_login
    authorized_worker = Worker.authenticate(params[:username_or_email],params[:login_password])
    if authorized_worker
      session[:worker_id] = authorized_worker.id
      session[:admin] = authorized_worker.admin
      flash[:success] = "Wow Welcome again, you logged in as #{authorized_worker.username}"
      render 'index'
    else
      flash[:danger] = 'Invalid Username or Password'
      render 'login'
    end
  end
end
