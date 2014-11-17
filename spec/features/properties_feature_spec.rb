require 'rails_helper'
describe 'As a logged in user' do 

  def fill_form
    fill_in('Postcode', :with => 'NW10 6RB')
    fill_in('area_property_rent', :with => 800)
    fill_in('area_landlord_investment', :with => 100000)
  end

  context 'I want to be able to add new properties and calculate yields' do
    before do
      fits = User.create(email: 'f@f.com', password: '12345678', password_confirmation: '12345678')
      login_as fits
      visit root_path
      click_link('New property?')
      fill_form
      click_button('Create property')
    end
    it 'and I can see the result in the index page' do 
      expect(page).to have_content 'NW106RB'
      expect(page).to have_content '£800'
      expect(page).to have_content '£100000'
      expect(page).to have_content '9.6%'
    end    
  end
end

describe 'As a logged out user' do 
  context 'I want to be able to add new properties and calculate yields' do
    before do
      visit root_path
      click_link('New property?')
    end
    it 'and I can see the result in the index page' do 
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end    
  end
end