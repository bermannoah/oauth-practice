class SessionsController < ApplicationController

				def create
					@response = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{ENV['GITHUB_CLIENT_KEY']}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}&code=#{params["code"]}")
					
					token = @response.body.split(/\W+/)[1]

					oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

					auth = JSON.parse(oauth_response.body)

					user					= User.find_or_create_by(uid: auth["uid"])
					user.username = auth["login"]
					user.uid			= auth["id"]
					user.token		= token
					user.save

					session[:user_id] = user.id

					redirect_to dashboard_index_path
				end
end
