require 'rails_helper'
describe 'As a user who is not logged in' do 
  context 'visiting the homepage with no listings' do
    it 'it tells me there are no postcodes' do 
      visit root_path
      expect(page).to have_content 'No Listings yet'
    end    
  end
  context 'trying to add a new listing' do
    before do
      visit root_path
      click_link('New property')
    end
    it 'it should redirect me to the sign in/up page' do 
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end    
  end
  context 'who wants to see specific postcodes and listing' do
    let!(:area) { Area.create(:postcode => 'NW106RB') }
    before do
      visit root_path
      click_link('NW106RB')
    end
    it 'it takes me to the individual postcode page' do 
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end    
  end
end

require 'rails_helper'
describe 'As a logged in user' do 

  def login_and_fill_form
    fits = User.create(email: 'f@f.com', password: '12345678', password_confirmation: '12345678')
    login_as fits
    visit root_path
    click_link('New property?')
    fill_in('Postcode', :with => 'NW10 6RB')
    fill_in('area_property_rent', :with => 800)
    fill_in('area_landlord_investment', :with => 100000)
    click_button('Create property')
  end

  context 'visiting the homepage with no listings' do
    it 'it tells me there are no postcodes' do 
      visit root_path
      expect(page).to have_content 'No Listings yet'
    end    
  end
  context 'visiting the homepage with listings' do
    before do
      login_and_fill_form
    end
    it 'it shows me the list of postcodes along with all properties associated with it' do 
      expect(page).to have_content 'NW106RB'
    end    
  end
  context 'who wants to see specific postcodes and listing' do
    before do
      login_and_fill_form
      click_link('NW106RB')
    end
    it 'it takes me to the individual postcode page' do 
      expect(page).to have_content 'All properties in NW106RB'
      expect(page).to have_content '£800'
      expect(page).to have_content '£100000'
      expect(page).to have_content '9.6%'
    end    
  end
  context 'when the rent and investment are not given' do
    before do
    fits = User.create(email: 'f@f.com', password: '12345678', password_confirmation: '12345678')
    login_as fits
    visit root_path
    click_link('New property?')
    fill_in('Postcode', :with => 'NW10 6RB')
    click_button('Create property')
    end
    it 'it shows a message saying what the error is' do 
      expect(page).to have_content "Please check to make sure that you have provided a valid rent or investment"
    end    
  end
  context 'when the postcode is not from the UK' do
    before do
    fits = User.create(email: 'f@f.com', password: '12345678', password_confirmation: '12345678')
    login_as fits
    visit root_path
    click_link('New property?')
    fill_in('Postcode', :with => 'Q3 7rB')
    fill_in('area_property_rent', :with => 800)
    fill_in('area_landlord_investment', :with => 100000)
    click_button('Create property')
    end
    it 'it shows a message saying what the error is' do 
      expect(page).to have_content "Please check to make sure that you have provided a valid post code"
    end    
  end
end