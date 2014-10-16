class User < ActiveRecord::Base

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.refresh_token = auth['credentials']['refresh_token']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

end
