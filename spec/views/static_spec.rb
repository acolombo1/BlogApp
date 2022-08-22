require 'rails_helper'

RSpec.describe 'Static content', type: :system do
  it 'shows the static text' do
    visit 'http://localhost:3000/'
    expect(page).to have_content('Here is a list of users of this page!')
  end
end
