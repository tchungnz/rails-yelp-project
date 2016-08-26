class Restaurant < ApplicationRecord

  belongs_to :user, dependent: :destroy
  has_many :reviews,
        -> { extending WithUserAssociationExtension },
        dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def average_rating
    if reviews.none?
      return 'No reviews'
    else
      return reviews.average(:rating).to_i
    end
  end

end
