module API
  module V1
    class BasicHealthUnitsController < ApplicationController
      before_action :set_basic_health_unit, only: %i[show update destroy]

      # GET /basic_health_units
      def index
        @basic_health_units = ::BasicHealthUnit.all

        render json: @basic_health_units
      end

      # GET /basic_health_units/1
      def show
        render json: @basic_health_unit
      end

      # POST /basic_health_units
      def create
        @basic_health_unit = BasicHealthUnit.new(basic_health_unit_params)

        if @basic_health_unit.save
          render json: @basic_health_unit, status: :created, location: @basic_health_unit
        else
          render json: @basic_health_unit.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /basic_health_units/1
      def update
        if @basic_health_unit.update(basic_health_unit_params)
          render json: @basic_health_unit
        else
          render json: @basic_health_unit.errors, status: :unprocessable_entity
        end
      end

      # DELETE /basic_health_units/1
      def destroy
        @basic_health_unit.destroy
      end

      def find_ubs
        if params[:query].present?
          operation = FindBasicHealthUnit.new(query: params[:query])

          operation.range = params[:range] if params[:range].present?
          if params[:per_page].present?
            operation.per_page = params[:per_page]
            operation.page     = params[:page] if params[:page].present?
          end

          operation.perform

          if operation.succeeded?
            render json: operation.result, status: 200
          else
            render json: operation.errors, status: :unprocessable_entity
          end
        else
          render json:   'FindBasicHealthUnit requires the property query to be set',
                 status: :unprocessable_entity
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_basic_health_unit
        @basic_health_unit = BasicHealthUnit.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def basic_health_unit_params
        params.require(:basic_health_unit).permit(
          :name,
          :address,
          :city,
          :phone,
          :score_id,
          :geocode_id
        )
      end
    end
  end
end
