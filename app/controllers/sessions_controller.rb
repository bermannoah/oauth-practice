class SessionsController < ApplicationController
				def create
					@response = Faraday.post("https://github.com/login/oauth/access_token?client_id=github_key&client_secret=github_secret&code=#{params["code"]}")
				end
				
				token = @response.body.split(/\w+/)[1]

				oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

				auth = JSON.parse(oauth_response.body)

				private

				github_secret = ENV["GITHUB_CLIENT_SECRET"]
				github_key = ENV["GITHUB_CLIENT_KEY"]
end

