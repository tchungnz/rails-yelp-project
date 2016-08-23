require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end


context 'restaurants have been added' do
  before do
    Restaurant.create(name: 'KFC')
  end

  scenario 'display restaurants' do
    visit '/restaurants'
    expect(page).to have_content('KFC')
    expect(page).not_to have_content('No restaurants yet')
  end
end

context 'creating restaurants' do
  scenario 'prompts user to fill out a form, then displays the new restaraunt' do
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
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
  scenario 'a user tries to create a restaurant that already exists' do
    
  end
end

context 'viewing restaurants' do
  let!(:kfc){ Restaurant.create(name: 'KFC')}

  scenario 'lets a user view a restaurant' do
    visit '/restaurants'
    click_link 'KFC'
    expect(page).to have_content 'KFC'
    expect(current_path).to eq "/restaurants/#{kfc.id}"
  end
end

context 'editing restaurants' do

  before {Restaurant.create name: 'KFC', description: 'Deep fried goodness'}

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
    Restaurant.create(name: 'KFC', description: 'Deep fried goodness')
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
