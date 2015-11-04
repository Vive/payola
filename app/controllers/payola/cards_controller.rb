module Payola
  class CardsController < ApplicationController
    before_action :check_modify_permissions, only: [:create, :destroy]

    def create
      if params[:customer_id].present? && params[:stripeToken].present?
        Payola::CreateCard.call(params[:customer_id], params[:stripeToken])
        redirect_to :back, notice: 'Succesfully created new card'
      else
        redirect_to :back, alert: 'Could not create new card'
      end
    end

    def destroy
      if params[:id].present? && params[:customer_id].present?
        Payola::DestroyCard.call(params[:id], params[:customer_id])
        redirect_to :back, notice: 'Succesfully removed the card'
      else
        redirect_to :back, alert: 'Could not remove the card'
      end
    end

    private

    def check_modify_permissions
      if self.respond_to?(:payola_can_modify_customer?)
        redirect_to(
          :back,
          alert: 'You cannot modify this customer.'
        ) && return unless self.payola_can_modify_customer?(params[:customer_id])
      end
    end
  end
end
