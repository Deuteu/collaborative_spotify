# frozen_string_literal: true

require 'rspotify/collection_retriever'

describe RSpotify::CollectionRetriever do
  describe '.get' do
    let(:lib_max) { 50 }

    before(:each) do
      allow(RSpotify::Base).to receive(:find) do |ids, _type, _market: nil|
        Array(ids).sample(lib_max).map { |id| RSpotify::Base.new('id' => id) }
      end
    end

    let(:internal_max) { lib_max }

    before(:each) do
      stub_const('RSpotify::CollectionRetriever::MAX', internal_max)
    end

    let(:ids) { [] }
    let(:result) { RSpotify::CollectionRetriever.get('type', ids) }

    context 'when there less ids than the internal maximum' do
      let(:ids) { Array(1..internal_max) }

      it 'returns all the ids' do
        expect(result.keys).to match_array(ids)
      end

      it 'calls do one network call' do
        result
        expect(RSpotify::Base).to have_received(:find).once
      end
    end

    context 'when there more ids than the maximum' do
      let(:ids) { Array(1..(internal_max * 2)) }

      context 'when internal maximum is less than the lib maximum' do
        let(:internal_max) { lib_max / 2 }

        it 'returns all the ids' do
          expect(result.keys).to match_array(ids)
        end

        it 'calls one time for each slice of internal maximum ids' do
          result
          expect(RSpotify::Base).
            to(have_received(:find).
              exactly(ids.each_slice(internal_max).count))
        end
      end

      context 'when internal maximum is more than the lib maximum' do
        let(:internal_max) { lib_max * 2 }

        it 'returns all the ids' do
          expect(result.keys).to match_array(ids)
        end

        it 'calls one time for each slice lib maximum ids by slice of internal maximum ids' do
          result
          expect(RSpotify::Base).
            to(have_received(:find).
              exactly(ids.each_slice(internal_max).sum { |s| s.each_slice(lib_max).count }))
        end
      end
    end
  end
end
