class ContactsController < ApplicationController
  before_action :authenticate_user
  # To ensure privacy perform all actions throuh current_user's
  # association
  def index
    @contacts = current_user
                .contacts
                .where(active: true)
                .order(id: :desc)
    render json: @contacts
  end

  def show
    # find will throw an error if contact doesn't belong to current_user
    @contact = current_user
               .contacts
               .where(active: true)
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
      render json: @contact, status: 200
    else
      logger.warn(@contact.errors.messages)
      render json: @contact.errors.messages, status: 400
    end
  end

  def update
    update_or_raise_error
  rescue StandardError => e
    logger.error(e)
    render json: { error: e }, status: 404
  end

  def destroy
    # find will throw an error if contact doesn't belong to current_user
    @contact = current_user
               .contacts
               .find(params[:id])
    @contact.update!(active: false)
    render json: {}, status: 200
  rescue StandardError => e
    logger.error(e)
    # we don't want to leak any info
    # to a malicious attacker, so we return 404 with no message
    render json: {}, status: 404
  end

  private

  # use fetch to prevent errors if contact not provided
  def contact_params
    params.fetch(:contact, {}).permit(
      :email, :name, :birthdate,
      :phone, :address, :organization
    )
  end

  def update_or_raise_error
    # find will throw an error if contact doesn't
    # belong to current_user
    @contact = current_user
               .contacts
               .where(active: true)
               .find(params[:id])
    if @contact.update(contact_params)
      render json: @contact, status: 200
    else
      render json: @contact.errors.messages,
             status: 400
    end
  end
end
