class Conversation < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: true
  has_many :messages, -> { order(created_at: :desc) }, dependent: :delete_all
  attribute :status, :string, default: -> { ACTIVE }

  # Built-in statuses
  ACTIVE = 1
  ARCHIVED = 2
end
