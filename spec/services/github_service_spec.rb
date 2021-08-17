require 'rails_helper'

RSpec.describe GithubService do
  describe 'class methods', :service do
    describe '#repo_info' do
      it 'queries repo info on GitHub', :vcr do
        response = GithubService.repo_info

        expect(response).to be_an_instance_of(Hash)
        expect(response[:name]).to eq('little-shop-of-rails')
      end
    end

    describe '#contributors_info' do
      it 'queries contributor info on GitHub', :vcr do
        response = GithubService.contributors_info

        expect(response.first[:login]).to eq('mkrumholz')
        expect(response.first[:contributions]).to eq(258)
      end
    end

    describe '#pull_request_info' do
      it 'queries pull request info on GitHub', :vcr do
        response = GithubService.pull_request_info

        expect(response.first[:id]).to eq 713687037
        expect(response.first[:merged_at]).to eq '2021-08-16T19:23:06Z'
      end
    end
  end
end
