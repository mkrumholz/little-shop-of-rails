class GithubRepo

   def self.name_info
     repo_info = GithubService.repo_info
      if !repo_info.keys.include?(:message)
        repo_info[:name]
      else
        "API rate limit exceeded."
      end
   end

end
