class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.all

    render json: @contacts #, methods: :birthdate_br #[:hello, :i18n]
  end

  # GET /contacts/1
  def show
    render json: @contact, include: [:kind, :phones, :address]
    #render json: { name: @contact.name, birthdate: (I18n.l(@contact.birthdate) unless @contact.birthdate.blank?) }#, include: :kind 
    # render json: @contact
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, include: [:kind, :phones, :address], status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact, include: [:kind, :phones, :address]
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end
  
  # POST /email_check
  def email_check 

    @contact = Contact.find_by(params[:email])
      render json: @contact
  
    # @contact = Contact.find(params[:email])
    # respond_to do |format|
    #   format.json {render :json => {email_exists: @contact.present?}}
    #   #format.json {render :json => @user} #this will output null if email is not in the database
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(
        :name, :email, :birthdate, :kind_id, 
        phones_attributes: [:id, :number, :_destroy],
        address_attributes: [:id, :street, :city]
        )
    end
end
