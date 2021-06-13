require 'rails_helper'

RSpec.describe GithubService do
  describe 'class methods', :service do
    describe '#repo_info' do
      it 'queries repo info on GitHub' do
        WebMock.stub_request(:get, /api.github.com/)
               .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Faraday v1.4.2' })
               .to_return(status: 200, body: { name: 'little-shop-of-rails' }.to_json, headers: {})

        uri = URI('https://api.github.com/repos/mkrumholz/little-shop-of-rails')

        response = GithubService.repo_info

        expect(response).to be_an_instance_of(Hash)
        expect(response[:name]).to eq('little-shop-of-rails')
      end
    end

    describe '#contributors_info' do
      it 'queries contributor info on GitHub' do
        WebMock.stub_request(:get, /api.github.com/)
               .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Faraday v1.4.2' })
               .to_return(status: 200, body: { login: 'mkrumholz', contributions: 177 }.to_json, headers: {})

        uri = URI('https://api.github.com/repos/mkrumholz/little-shop-of-rails/contributors')

        response = GithubService.contributors_info

        expect(response[:login]).to eq('mkrumholz')
        expect(response[:contributions]).to eq(177)
      end
    end

    describe '#pull_request_info' do
      it 'queries pull request info on GitHub' do
        WebMock.stub_request(:get, /api.github.com/)
               .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Faraday v1.4.2' })
               .to_return(status: 200, body: { id: 668978499, merged_at: '2021-06-13T02:31:59Z' }.to_json, headers: {})

        uri = URI('https://api.github.com/repos/mkrumholz/little-shop-of-rails/pulls?state=closed')

        response = GithubService.pull_request_info
        expect(response[:id]).to eq 668978499
        expect(response[:merged_at]).to eq '2021-06-13T02:31:59Z'
      end
    end
  end
end
