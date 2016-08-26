require 'rails_helper'
require 'features/feature_spec_helper'

feature 'endorsements' do

  before do
    sign_up
    create_new_restaurant
    sign_up2
    leave_review("really good", 3)
  end

  scenario 'a user endorses a review, which updates the review endorsement count', js: true do
    visit restaurants_path
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end

end
