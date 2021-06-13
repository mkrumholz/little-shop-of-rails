class GithubService
  def self.repo_info
    response = Faraday.get 'https://api.github.com/repos/mkrumholz/little-shop-of-rails'

    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  def self.contributors_info
    response = Faraday.get 'https://api.github.com/repos/mkrumholz/little-shop-of-rails/contributors'

    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  def self.closed_pulls
    response = Faraday.get 'https://api.github.com/repos/mkrumholz/little-shop-of-rails/pulls?state=closed'

    body = response.body
    JSON.parse(body, symbolize_names: true)
  end
end
