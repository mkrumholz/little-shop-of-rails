require 'rails_helper'

RSpec.describe GithubRepo do
  describe '.name' do
    it 'returns the name of the repo' do
      allow(GithubService).to receive(:repo_info).and_return({
                                                               name: 'little-esty-shop'
                                                             })

      expect(GithubRepo.name_info).to eq('little-esty-shop')
    end
    it 'returns an error if the api limit is exceeded' do
      allow(GithubService).to receive(:repo_info).and_return({
                                                               message: 'error',
                                                               name: 'little-esty-shop'
                                                             })

      expect(GithubRepo.name_info).to eq('Unavailable: API rate limit exceeded.')
    end
  end
end
