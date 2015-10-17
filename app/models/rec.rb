class Rec < ActiveRecord::Base
	mount_uploader :attachment, AttachmentUploader
	
	belongs_to :company
	belongs_to :union
	belongs_to :person
	has_many :posts, :as => :parent
	
	validates :name, :company, :union, :person, :end_date, presence: true

	serialize :nature_of_operation, Array

	acts_as_followable

	def post_title
		"Post your question or industrial action pics here"
	end
end
