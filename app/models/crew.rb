class Crew < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :age, :name, :avatar, :title, :species, :origin, :unless => proc { new_record? }
end
