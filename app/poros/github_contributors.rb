class GithubContributors

  def self.contributors_info
    github_contributor_data = GithubService.contributors_info
    if github_contributor_data.is_a? Array
      github_contributor_data.each_with_object({}) do |contributor, hash|
        if [26797256, 78388882, 5446926, 78574189].include?(contributor[:id])
          hash[contributor[:id]] = {name: contributor[:login], contributions: contributor[:contributions]}
        end
      end
    else
      [["error", { name: "Unavailable: API rate limit exceeded.", contributions: "Unavailable: API rate limit exceeded."}]]
    end
  end
end
