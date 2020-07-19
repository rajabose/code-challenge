class Company < ApplicationRecord
  has_rich_text :description
  validates_format_of :email, presence: true, :with => /\A[\w]([^@\s,;]+)@(mainstreet.com)\z/i,
  :message => "must end with mainstreet.com", :on => [:create, :update]
  validates_format_of :zip_code, with: /\A\d{5}-\d{4}|\A\d{5}\z/, 
  :message => "should be valid, should be 12345 or 12345-1234", :on => [:create, :update]

end
