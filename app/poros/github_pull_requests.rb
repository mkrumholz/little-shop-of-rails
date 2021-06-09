class GithubPullRequests

  def self.merged_pulls
    GithubService.closed_pulls.count do |pr|
      !pr[:merged_at].nil?
    end
  end

end
