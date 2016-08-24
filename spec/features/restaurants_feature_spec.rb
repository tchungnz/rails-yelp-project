require 'rails_helper'
require 'features/feature_spec_helper'

feature 'restaurants' do
  before do
    sign_up
  end

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      create_new_restaurant
    end
    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaraunt' do
      create_new_restaurant
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'KFC'
    end
    scenario 'a user tries to create a restauarant with a name less than 3 chars' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KF'
      click_button 'Create Restaurant'
      expect(page).to have_content 'error'
      expect(page).not_to have_css 'h2' , text: 'kf'
    end
  end

  context 'viewing restaurants' do
    before do
      create_new_restaurant
    end
    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(page).to have_content 'Deep fried goodness'
      expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
    end
  end

  context 'editing restaurants' do
    before do
      create_new_restaurant
    end
    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      expect(page).to have_content('Kentucky Fried Chicken')
      expect(page).to have_content('Deep fried goodness')
      expect(current_path).to eq "/restaurants"
    end
  end

  context 'deleting restaurants' do
    before do
      create_new_restaurant
    end

    scenario 'let a user delete a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      click_link 'Delete KFC'
      expect(page).not_to have_content('Kentucky Fried Chicken')
      expect(page).not_to have_content('Deep fried goodness')
      expect(current_path).to eq '/restaurants'
    end
  end

end
