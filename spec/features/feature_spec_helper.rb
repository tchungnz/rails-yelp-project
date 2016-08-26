def sign_up
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def sign_up2
  visit('/')
  click_link('Sign out')
  click_link('Sign up')
  fill_in('Email', with: 'test2@example.com')
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

def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link "Review KFC"
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Submit Review'
end
