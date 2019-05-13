# frozen_string_literal: true

class ViewsController < ActionController::Base
  layout nil
  prepend_view_path 'app' # => app/view

  def home; end
end
