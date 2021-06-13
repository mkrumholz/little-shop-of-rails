require 'rails_helper'

RSpec.describe GithubRepo do
  describe '.name' do
    it 'returns the name of the repo' do
      allow(GithubService).to receive(:repo_info).and_return({
        name: 'little-shop-of-rails'
      })

      expect(GithubRepo.name_info).to eq('little-shop-of-rails')
    end
    it 'returns an error if the api limit is exceeded' do
      allow(GithubService).to receive(:repo_info).and_return({
        message: 'error',
        name: 'little-shop-of-rails'
      })

      expect(GithubRepo.name_info).to eq('Unavailable: API rate limit exceeded.')
    end
  end
end
