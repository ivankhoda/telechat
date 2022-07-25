class Conversation < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: true
  # validates_length_of :name, maximum: 30
  has_many :messages, dependent: :delete_all
  attribute :status, :string, default: -> { ACTIVE }

  # Built-in statuses
  ACTIVE = 1
  ARCHIVED = 2
end
