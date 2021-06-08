class GithubContributors
  attr_reader

  def initialize
    @github_contributor_data = GithubService.contributors_info
  end

  def contributor_info
    @github_contributor_data.each_with_object do |contributor, hash|
      hash[contributor[:id]] = contributor
    end
  end

end
