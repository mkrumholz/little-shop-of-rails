class GithubService
  def self.repo_info
    response = Faraday.get 'https://api.github.com/repos/LawrenceWhalen/little-esty-shop'

    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  def self.contributors_info
    response = Faraday.get 'https://api.github.com/repos/LawrenceWhalen/little-esty-shop/contributors'

    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  def self.closed_pulls
    response = Faraday.get 'https://api.github.com/repos/LawrenceWhalen/little-esty-shop/pulls?state=closed'

    body = response.body
    JSON.parse(body, symbolize_names: true)
  end
end
