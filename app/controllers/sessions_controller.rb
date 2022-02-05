class SessionsController < ApplicationController
  before_action :set_user, except: %i[ index ]
  before_action :validate_user!, except: %i[ index new ]

  # GET / or /index.json
  def index
    respond_to do |format|
      if current_user
        format.html { redirect_to new_shipment_path }
        format.json { render json: {}, status: :ok, location: new_shipment_path }
      else
        format.html { redirect_to new_session_path }
        format.json { render json: {}, status: :ok, location: new_session_path }
      end
    end
  end

  # GET /sessions/new
  def new
  end

  # GET /sessions/:phone/edit
  def edit
  end

  # POST /sessions or /sessions.json
  def create
    @user&.reset_mfa_code

    respond_to do |format|
      if @user.save
        format.html { redirect_to edit_session_path(id: @user.phone) }
        format.json { render :show, status: :created, location: session_url(@user.phone) }
      else
        format.html { redirect_to new_session_path, notice: "Unable to generate verificaiton code, please try again." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sessions/:phone or /sessions/:phone.json
  def update
    respond_to do |format|
      if @user&.valid_mfa_code?(session_params[:verification_code])
        format.html { redirect_to new_shipment_path, notice: "User authenticated." }
        format.json { render json: {}, status: :ok, location: new_shipment_path }
      else
        format.html { render :edit, notice: "Invalid verification code, please try again." }
        format.json { render json: { errors: [{ verification_code: :invalid}] }, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      user_id_param = session_params[:id] || session_params.dig(:user, :phone)

      @user = User.find_or_initialize_by(phone: user_id_param)
    end

    def validate_user!
      return unless @user.new_record?

      respond_to do |format|
        format.html { redirect_to new_session_path(id: @user.phone), notice: "User not found." }
        format.json { render json: { errors: [{ phone: :invalid}] }, status: :unprocessable_entity }
      end

    end

    # Only allow a list of trusted parameters through.
    def session_params
      @session_params ||= params.permit(:id, user: [ :phone, :verification_code ])
    end
end
