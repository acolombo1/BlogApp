require 'rails_helper'

RSpec.describe 'Static content', type: :system do

  it 'Main page shows all users' do
    visit('http://localhost:3000/')
    expect(page).to have_content('Lilly')
    expect(page).to have_content('Tom')
  end
end
