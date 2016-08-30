require "rails_helper"

RSpec.feature "Tools work" do
  scenario "index works" do
    login_as(Fabricate(:user), scope: :user)
    visit "/tools"
    expect(page).to have_content
  end
  scenario "new tools show up in the table" do
  #   login_as(Fabricate(:user))
  #   tools = Fabricate.times(2, :tool)
  #   visit "/tools"
  #   tools.map(&:name).each do |tool_name|
  #     expect(page).to have_text(tool_name)
  #   end
  end
end
