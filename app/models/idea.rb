class Idea < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :nullify

  validates(:title, { presence: true })
  validates(:description, { presence: true })
end
