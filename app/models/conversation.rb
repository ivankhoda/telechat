class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy, inverse_of: :conversation
end
