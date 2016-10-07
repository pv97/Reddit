class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  belongs_to :parent_comment,
  primary_key: :id,
  foreign_key: :parent_id,
  class_name: :Comment

  has_many :child_comments,
  primary_key: :id,
  foreign_key: :parent_id,
  class_name: :Comment

end
