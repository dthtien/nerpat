class UsersController < ApplicationController
  before_action :authenticate_user

  rescue_from ActiveRecord::RecordNotFound, with: :not_available 

  def add_nerge
    @nerge = current_user.available_nerges.find(params[:id])
    current_user.nerges << @nerge
    
    flash[:notice] = 'Added nerge'
    redirect_to root_path
  end

  def remove_nerge
    @nerge = current_user.nerges.find(params[:id])
    @nerge.update(patron_id: nil)

    flash[:alert] = 'Removed nerge'
    redirect_to  current_user.profile
  end

  def add_patron
    @patron = current_user.available_patrons.find(params[:id])
    @patron.nerges << current_user
    
    flash[:notice] = 'Added patron'
    redirect_to root_path
  end

  def remove_patron
    current_user.update(patron_id: nil)

    flash[:alert] = 'Removed patron'
    redirect_to  current_user.profile
  end

  private
    def not_available
      flash[:alert] = "Nerge/Patron này không thể nhận. Vui lòng thử lại."
      redirect_to root_path
    end
end
