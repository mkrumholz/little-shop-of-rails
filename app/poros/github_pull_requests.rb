class GithubPullRequests

  def self.merged_pulls
    possible_merged = GithubService.closed_pulls
    if !possible_merged[0].keys.include?(:message)
      possible_merged.count do |pr|
        !pr[:merged_at].nil?
      end
    else
      "API rate limit exceeded."
    end
  end
end
