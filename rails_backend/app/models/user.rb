class User < ApplicationRecord
    validates :name, :nick_name, :email, :password, :number, presence: true
end
