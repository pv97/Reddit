class Post < ActiveRecord::Base
  has_many :post_subs, inverse_of: :post

  has_many :comments
  has_many :subs,
  through: :post_subs



  belongs_to :user
end
