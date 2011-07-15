class User
  include Mongoid::Document
  field :name, :type => String
  field :email, :type => String
  field :avatar, :type => String
  embeds_many :authorizations
  
  def self.create_with_omniauth(auth)
    begin
      create! do |user|
        user.authorizations.new(provider: auth['provider'], uid: auth['uid'])
        if auth['user_info']
          user.name = auth['user_info']['name'] if auth['user_info']['name'] # Twitter, Google, Yahoo, GitHub
          user.email = auth['user_info']['email'] if auth['user_info']['email'] # Google, Yahoo, GitHub
          user.avatar = auth['user_info']['profile_image_url'] if auth['user_info']['profile_image_url'] # Twitter
          user.avatar = auth['user_info']['image'] if auth['user_info']['image'] # TSina
        end
        if auth['extra']['user_hash']
          user.name = auth['extra']['user_hash']['name'] if auth['extra']['user_hash']['name'] # Facebook
          user.email = auth['extra']['user_hash']['email'] if auth['extra']['user_hash']['email'] # Facebook
        end
      end
    rescue Exception => e
      raise Exception, "cannot create user record"
    end
  end
end
