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

      it 'returns an error hash if api limit exceeded' do
        allow(GithubService).to receive(:contributors_info).and_return(
          {
          :message=>"API rate limit exceeded for 98.38.149.214. (But here's the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details.)",
          :documentation_url=>"https://docs.github.com/rest/overview/resources-in-the-rest-api#rate-limiting"}
        )

        expect(GithubContributors.contributors_info[0][1][:name]).to eq("API rate limit exceeded.")
        expect(GithubContributors.contributors_info[0][1][:contributions]).to eq('')
      end
    end
  end
end
