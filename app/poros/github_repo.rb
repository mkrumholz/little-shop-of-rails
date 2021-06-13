class GithubRepo
  def self.name_info
    repo_info = GithubService.repo_info
    if repo_info.keys.include?(:message)
      'Unavailable: API rate limit exceeded.'
    else
      repo_info[:name]
    end
  end
end
