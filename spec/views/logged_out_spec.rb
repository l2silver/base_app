require "rails_helper"

describe "static_pages/logged_out.html.erb" do
  it "processes logged out app" do
    render
    expect(rendered).to include("LoggedOutApp")
  end

   it "processes logged out controller" do
    render
    expect(rendered).to include("LoggedOutController")
  end
end