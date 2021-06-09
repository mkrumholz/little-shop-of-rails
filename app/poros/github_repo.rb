class GithubRepo

   def self.name
     GithubService.repo_info[:name]
   end

end
