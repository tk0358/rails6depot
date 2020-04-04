class Pay < ApplicationRecord
  validates :way, presence: true, uniqueness: true, inclusion: { in: ['Check', 'Credit card', 'Purchase order']}
end