# frozen_string_literal: true

module RSpotify
  module CollectionRetriever
    MAX = 50
    private_constant :MAX

    class << self
      def get(type, ids)
        Array(ids).each_slice(MAX).each_with_object({}) do |sliced_ids, track_by_id|
          missing_ids = sliced_ids
          while missing_ids.any?
            tracks = RSpotify::Base.find(missing_ids, computed_type(type))
            break if tracks.empty?

            new_ids = tracks.map(&:id)
            break if (new_ids - track_by_id.keys).empty? # No new ids

            tracks.each do |t|
              track_by_id[t.id] = t
            end
            missing_ids -= new_ids
          end
        end
      end

      private

      def computed_type(type)
        (type.is_a?(Class) ? type.name : type).demodulize.underscore
      end
    end
  end
end
