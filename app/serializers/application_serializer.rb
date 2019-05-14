# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  def attributes(requested_attrs = nil, reload = false)
    super.tap(&:compact!)
  end
end
