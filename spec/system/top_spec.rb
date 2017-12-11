require 'rails_helper'

RSpec.describe TopController, type: :system do
  describe '#index', js: true do
    it 'should get top page' do
      visit '/'
      expect(page).to have_content 'Hello World'
      expect(page).to have_content 'Hello Javascript'
    end
  end

  describe '#index', js: false do
    it 'should get top page' do
      visit '/'
      expect(page).to have_content 'Hello World'
      expect(page).to_not have_content 'Hello Javascript'
    end
  end
end