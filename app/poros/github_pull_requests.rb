class GithubPullRequests
  attr_reader

  def initialize
    @github_pull_requests = GithubService.closed_pulls
  end

  def merged_pulls
    @github_pull_requests.count do |pr|
      !pr[:merged_at].nil?
    end
  end

end
