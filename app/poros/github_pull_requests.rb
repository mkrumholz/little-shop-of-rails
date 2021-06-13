class GithubPullRequests
  def self.merged_pulls
    possible_merged = GithubService.pull_request_info
    if possible_merged.is_a? Array
      possible_merged.count do |pr|
        !pr[:merged_at].nil?
      end
    else
      'Unavailable: API rate limit exceeded.'
    end
  end
end
