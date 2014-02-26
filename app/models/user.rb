class User < ActiveRecord::Base
  has_many :games
  has_secure_password

  validates :email,
    :presence => true,
    :uniqueness => true,
    :length => { :maximum => 255 }#,
    # :format => { :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i }

  validates :name,
    :length => { :maximum => 255 },
    :allow_blank => true

  validates :password,
    :presence => { :on => :create }
end
