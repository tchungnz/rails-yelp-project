def sign_up
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def create_new_restaurant
  visit('/restaurants')
  click_link 'Add a restaurant'
  fill_in('Name', with: 'KFC')
  fill_in('Description', with: "Deep fried goodness")
  click_button('Create Restaurant')
end
