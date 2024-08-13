class User < ApplicationRecord
    validates :name, :nick_name, :email, :password, :number, presence: true
    validates :number, numericality: { only_integer: true }
    validates :name, :nick_name, :email, uniqueness: true
    belongs_to :user_stat
end
