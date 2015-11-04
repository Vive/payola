require 'active_support/concern'

module Payola
  module GuidBehavior
    extend ActiveSupport::Concern

    included do
      before_save :populate_guid
      validates_uniqueness_of :guid
    end

    def populate_guid
      if new_record?
        self.guid = Payola.guid_generator.call while !valid? || guid.nil?
      end
    end
  end
end
