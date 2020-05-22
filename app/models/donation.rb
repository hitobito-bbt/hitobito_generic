class Donation < ActiveRecord::Base
  belongs_to :person
  validates_by_schema
  include CurrencyHelper

  validates :description, :amount, presence: true
  validates :description, length: { maximum: 1023  }

  before_validation :set_issued_at

  scope :list, -> { order(issued_at: :desc) }

  def to_s
    [description.to_s.truncate(20), number_to_currency(amount)].join(' - ') if persisted?
  end

  private

  def set_issued_at
    self.issued_at ||= Date.today
  end
end
