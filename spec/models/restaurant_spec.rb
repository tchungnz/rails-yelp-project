require 'rails_helper'

describe Restaurant, type: :model do

  it 'is not valid with a name of less than 3 chars' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid if the name already exists' do
    Restaurant.create(name: "Georgia's Garage")
    restaurant = Restaurant.new(name: "Georgia's Garage")
    expect(restaurant).to have(1).error_on(:name)
  end

end
