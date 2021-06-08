require 'rails_helper'

RSpec.describe GithubRepo do
  describe 'initialize' do
    it 'returns the name of the repo' do
      allow(GithubService).to receive(:repo_info).and_return({
          name: 'little-esty-shop'
      })

      actual = GithubRepo.new

      expect(actual.name).to eq('little-esty-shop')
    end
  end
end
