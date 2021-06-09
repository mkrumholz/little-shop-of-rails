class GithubRepo

   def self.name_info
     GithubService.repo_info[:name]
   end

end
