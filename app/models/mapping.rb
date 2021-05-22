class Mapping < ApplicationRecord
  has_one :question,dependent: :destroy
end
