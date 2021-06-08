require 'rails_helper'

RSpec.describe GithubContributors do
  describe 'instance methods' do
    describe '#contributor_info' do
      it 'returns a hash with key of id and value of contributor info' do
        allow(GithubService).to receive(:contributors_info).and_return([
          {
           id: 26797256,
           name: 'Molly',
           contributions: 7
           },
          {
           id: 5446926,
           name: 'Sa,',
           contributions: 80
          }
        ])

        expect(GithubContributors.contributors_info.keys.first).to eq(26797256)
        expect(GithubContributors.contributors_info.values.first.class).to eq(Hash)
      end
    end
  end
end
