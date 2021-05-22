class Role < ApplicationRecord
  has_one :question,dependent: :destroy
end
