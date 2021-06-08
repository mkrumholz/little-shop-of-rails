class GithubPullRequests

  def self.merged_pulls
    github_pull_requests = GithubService.closed_pulls
    github_pull_requests.count do |pr|
      !pr[:merged_at].nil?
    end
  end

end
