class GithubRepo
  attr_reader :name

   def initialize
     github_data = GithubService.repo_info
     @name = github_data[:name]
   end
   
end
