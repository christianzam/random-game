class SantaController < ApplicationController
  before_action :set_santum, only: %i[ show edit update destroy ]

  # GET /santa or /santa.json
  def index
    @santa = Santum.all
  end

  # GET /santa/1 or /santa/1.json
  def show
  end

  # GET /santa/new
  def new
    @santum = Santum.new
  end

  # GET /santa/1/edit
  def edit
  end

  # POST /santa or /santa.json
  def create
    @santum = Santum.new(santum_params)

    respond_to do |format|
      if @santum.save
        format.html { redirect_to santum_url(@santum), notice: "Santum was successfully created." }
        format.json { render :show, status: :created, location: @santum }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @santum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /santa/1 or /santa/1.json
  def update
    respond_to do |format|
      if @santum.update(santum_params)
        format.html { redirect_to santum_url(@santum), notice: "Santum was successfully updated." }
        format.json { render :show, status: :ok, location: @santum }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @santum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /santa/1 or /santa/1.json
  def destroy
    @santum.destroy

    respond_to do |format|
      format.html { redirect_to santa_url, notice: "Santum was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_santum
      @santum = Santum.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def santum_params
      params.require(:santum).permit(:nickname, :email, :give_to, :user_id)
    end
end
