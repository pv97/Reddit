class Sub < ActiveRecord::Base
  has_many :post_subs

  has_many :posts,
  through: :post_subs

  belongs_to :moderator,
    class_name: :User,
    primary_key: :id,
    foreign_key: :moderator_id

end
