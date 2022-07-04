class Message < ApplicationRecord
  belongs_to :conversation, inverse_of: :conversation
  belongs_to :user
end
