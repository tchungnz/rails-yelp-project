require 'rails_helper'
require 'features/feature_spec_helper'

describe Restaurant, type: :model do

  it 'is not valid with a name of less than 3 chars' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid if the name already exists' do
    User.create(email: 'tim@test.com', password: "password")
    Restaurant.create(name: 'KFC', user_id: User.last.id)
    restaurant = Restaurant.new(name: 'KFC', user_id: User.last.id)
    expect(restaurant).to have(1).error_on(:name)
  end

  describe 'reviews' do
    describe 'build_with_user' do

      let(:user) { User.create email: 'test@test.com' }
      let(:restaurant) { Restaurant.create name: 'Test' }
      let(:review_params) { {rating: 5, thoughts: 'yum'} }

      subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

      it 'builds a review' do
        expect(review).to be_a Review
      end

      it 'builds a review associated with the specified user' do
        expect(review.user).to eq user
      end
    end
  end

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns "No reviews" when there are no reviews' do
        User.create(email: 'tim@test.com', password: "password")
        restaurant = Restaurant.create(name: 'KFC', user_id: User.last.id)
        expect(restaurant.average_rating).to eq 'No reviews'
      end
    end
    context 'one review' do
      it 'returns 5 when there is one 5 star review' do
        User.create(email: 'tim@test.com', password: "password")
        @restaurant = Restaurant.create(name: 'KFC', user_id: User.last.id)
        @restaurant.reviews.create(thoughts: "okay", rating: 5, user_id: User.last.id)
        expect(@restaurant.average_rating).to eq 5
      end
    end
  end

end
