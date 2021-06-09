class GithubContributors

  def self.contributors_info
    github_contributor_data = GithubService.contributors_info
    require "pry"; binding.pry
    if github_contributor_data[:message] != nil
      github_contributor_data.each_with_object({}) do |contributor, hash|
        if [26797256, 78388882, 5446926, 78574189].include?(contributor[:id])
          hash[contributor[:id]] = {name: contributor[:login], contributions: contributor[:contributions]}
        end
      end
    else
      print "API rate limit exceeded for 173.232.242.12. (But here's the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details.)"
    end
  end
end
