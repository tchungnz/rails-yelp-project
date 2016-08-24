require 'rails_helper'
require 'features/feature_spec_helper'

feature 'reviewing' do
    before do
      sign_up
      create_new_restaurant
    end

  scenario 'a user wants to review an existing restaurant' do
    visit '/restaurants'
    click_link "Review KFC"
    fill_in 'Thoughts', with: 'really average'
    select '1', from: 'Rating'
    click_button 'Submit Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'really average'
  end

end
