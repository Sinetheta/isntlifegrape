require 'rails_helper'

RSpec.describe Tasting, :type => :model do
  it 'should not save tasting without title' do
    tasting = Tasting.new
    expect(tasting.save).to be false
  end
end
