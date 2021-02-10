class Todo < ApplicationRecord
	belongs_to :project

	def to_hash
 		{ id: self.id, text: self.text, isCompleted: self.isCompleted }
	end
end
