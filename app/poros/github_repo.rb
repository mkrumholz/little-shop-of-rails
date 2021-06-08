class GithubRepo

   def self.name
     github_data = GithubService.repo_info
     github_data[:name]
   end

end
