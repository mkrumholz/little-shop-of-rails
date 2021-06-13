class GithubContributors
  def self.contributors_info
    github_contributor_data = GithubService.contributors_info
    if github_contributor_data.is_a? Array
      only_team_data(github_contributor_data)
    else
      error_message
    end
  end

  def self.only_team_data(data)
    data.each_with_object({}) do |contributor, hash|
      if [26_797_256, 78_388_882, 5_446_926, 78_574_189].include?(contributor[:id])
        hash[contributor[:id]] =
          { name: contributor[:login], contributions: contributor[:contributions] }
      end
    end
  end

  def self.error_message
    [['error',
      { name: 'Unavailable: API rate limit exceeded.',
        contributions: 'Unavailable: API rate limit exceeded.' }]]
  end
end
