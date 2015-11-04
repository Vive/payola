class Product < ActiveRecord::Base
  include Payola::Sellable

  def redirect_path(_sale)
    '/'
  end
end
