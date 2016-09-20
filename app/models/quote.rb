class Quote < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :lists, table_name: 'lists_quotes'
  validates :title, :content, presence: true
end
