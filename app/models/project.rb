class Project < ApplicationRecord
  has_many :todo

	def to_hash
 		{ id: self.id, title: self.title }
	end
end
