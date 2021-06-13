require 'rails_helper'

RSpec.describe GithubPullRequests do
  describe 'class methods' do
    describe '.merged_pulls' do
      it 'returns a count of merged pull requests' do
        allow(GithubService).to receive(:pull_request_info).and_return([
          { id: 0o101010011, merged_at: 7 },
          { id: 0o1011230011, merged_at: 80 },
          { id: 0o1011230011, merged_at: nil }
        ])

        expect(GithubPullRequests.merged_pulls).to eq(2)
      end

      it 'returns an error if the api count is exceeded' do
        allow(GithubService).to receive(:pull_request_info).and_return(
          {
            :message => "API rate limit exceeded for 98.38.149.214. (But here's the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details.)",
            :documentation_url => 'https://docs.github.com/rest/overview/resources-in-the-rest-api#rate-limiting'
          }
        )

        expect(GithubPullRequests.merged_pulls).to eq('Unavailable: API rate limit exceeded.')
      end
    end
  end
end
