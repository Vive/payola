module Payola
  class CustomersController < ApplicationController
    before_action :check_modify_permissions, only: [:update]

    def update
      if params[:id].present?
        Payola::UpdateCustomer.call(params[:id], customer_params)
        redirect_to :back, notice: 'Succesfully updated customer'
      else
        redirect_to :back, alert: 'Could not update customer'
      end
    end

    private

    # Only including default_source for now, though other attributes can be used
    # (https://stripe.com/docs/api#update_customer)
    def customer_params
      params.require(:customer).permit(:default_source)
    end

    def check_modify_permissions
      if self.respond_to?(:payola_can_modify_customer?)
        redirect_to(
          :back,
          alert: 'You cannot modify this customer.'
        ) && return unless self.payola_can_modify_customer?(params[:id])
      end
    end
  end
end
