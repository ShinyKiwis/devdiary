# frozen_string_literal: true

class Bug < ApplicationRecord
  include AASM

  validates :title, presence: true
  validates :description, presence: true
  validates :context, presence: true

  has_one :environment, dependent: :destroy
  has_many_attached :attachments

  accepts_nested_attributes_for :environment

  enum difficulty_level: {
    easy: 'easy',
    medium: 'medium',
    hard: 'hard',
  }

  aasm column: :status do
    state :open, initial: true
    state :in_progress
    state :resolved
    state :closed

    event :start do
      transitions from: :open, to: :in_progress
    end

    event :resolve do
      transitions from: :in_progress, to: :resolved
    end

    event :close do
      transitions from: :open, to: :closed
      transitions from: :in_progress, to: :closed
    end
  end

  def try_resolve!
    resolve! if may_resolve?
  end
end
