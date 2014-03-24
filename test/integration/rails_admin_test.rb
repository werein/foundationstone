require 'test_helper'

describe "Rails Admin Feature" do
  it "must access to dashboard" do
    visit rails_admin.dashboard_path
    current_path.must_equal rails_admin.dashboard_path
  end

  it "must access to localized dashboard" do
    visit rails_admin.dashboard_path(locale: :cs)
    current_path.must_equal '/foundationstone/cs/admin/'
  end
end