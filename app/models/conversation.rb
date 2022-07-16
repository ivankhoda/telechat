class Conversation < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: true
  validates_length_of :name, maximum: 20
  has_many :messages, dependent: :destroy

  # Built-in statuses
  BUILTIN_NEW = 1
  BUILTIN_ARCHIVED = 2
end
