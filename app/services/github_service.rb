class GithubService

  def self.repoinfo
    response = Faraday.get "https://api.github.com/repos/LawrenceWhalen/little-esty-shop"

    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  def self.contributorsinfo
    response = Faraday.get "https://api.github.com/repos/LawrenceWhalen/little-esty-shop/contributors"

    body = response.body
    JSON.parse(body, symbolize_names: true)
  end
  
end
