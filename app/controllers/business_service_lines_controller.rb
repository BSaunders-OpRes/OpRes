class BusinessServiceLinesController < ApplicationController
  before_action :set_business_service_line, only: %i[ show edit update destroy ]

  # GET /business_service_lines or /business_service_lines.json
  def index
    @business_service_lines = BusinessServiceLine.all
  end

  # GET /business_service_lines/1 or /business_service_lines/1.json
  def show
  end

  # GET /business_service_lines/new
  def new
    @business_service_line = BusinessServiceLine.new
  end

  # GET /business_service_lines/1/edit
  def edit
  end

  # POST /business_service_lines or /business_service_lines.json
  def create
    @business_service_line = BusinessServiceLine.new(business_service_line_params)

    respond_to do |format|
      if @business_service_line.save
        format.html { redirect_to @business_service_line, notice: "Business service line was successfully created." }
        format.json { render :show, status: :created, location: @business_service_line }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @business_service_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /business_service_lines/1 or /business_service_lines/1.json
  def update
    respond_to do |format|
      if @business_service_line.update(business_service_line_params)
        format.html { redirect_to @business_service_line, notice: "Business service line was successfully updated." }
        format.json { render :show, status: :ok, location: @business_service_line }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @business_service_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_service_lines/1 or /business_service_lines/1.json
  def destroy
    @business_service_line.destroy
    respond_to do |format|
      format.html { redirect_to business_service_lines_url, notice: "Business service line was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business_service_line
      @business_service_line = BusinessServiceLine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def business_service_line_params
      params.require(:business_service_line).permit(:organisational_unit_id, :name, :tier)
    end
end
