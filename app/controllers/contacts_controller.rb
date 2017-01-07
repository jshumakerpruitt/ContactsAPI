class ContactsController < ApplicationController
  before_action :authenticate_user
  # To ensure privacy perform all actions throuh current_user's
  # association

  def index
    @contacts = current_user
                .contacts
                .order(id: :desc)
    render json: @contacts
  end

  def show
    # find will throw an error if contact doesn't belong to current_user
    @contact = current_user
               .contacts
               .find(params[:id])
    render json: @contact, status: 200
  rescue StandardError
    render json: {}, status: 400
  end

  def create
    @contact = current_user
               .contacts
               .build(contact_params)
    if @contact.save
      render json: {}, status: 200
    else
      render json: @contact.errors, status: 400
    end
  end

  def destroy
    # find will throw an error if contact doesn't belong to current_user
    current_user
      .contacts
      .find(params[:id])
      .destroy
    render json: {}, status: 200
  rescue StandardError
    render json: {}, status: 400
  end

  private

  def contact_params
    params.fetch(:contact, {}).permit(
      :email, :name, :birthdate,
      :phone, :address
    )
  end
end
