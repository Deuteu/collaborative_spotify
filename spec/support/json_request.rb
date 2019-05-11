# frozen_string_literal: true

module JsonRequest
  def json_header
    {ACCEPT: 'application/json'}.stringify_keys!
  end
end
