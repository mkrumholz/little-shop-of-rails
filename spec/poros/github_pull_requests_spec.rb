require 'rails_helper'

RSpec.describe GithubPullRequests do
  describe 'class methods' do
    describe '.merged_pulls' do
      it 'returns a count of merged pull requests' do
        allow(GithubService).to receive(:closed_pulls).and_return([
          {
           id: 0101010011,
           name: 'Molly',
           merged_at: 7
           },
          {
           id: 01011230011,
           name: 'Sa,',
           merged_at: 80
         },
          {
           id: 01011230011,
           name: 'Sa,',
           merged_at: nil
          }
        ])

        expect(GithubPullRequests.merged_pulls).to eq(2)
      end
    end
  end
end
