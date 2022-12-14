class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #do login
      reset_session
      log_in user
      redirect_to user
    else
      #error
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
       render 'new', status: :unprocessable_entity
    end
  end

    def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
