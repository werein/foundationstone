require 'test_helper'

describe Foundationstone::ApplicationHelper do 
  it "should generate icon" do 
    i('add').must_equal '<i class="add"></i>'
  end

  it "should generate glyphicon" do 
    glyphicon('add').must_equal '<i class="glyphicon glyphicon-add"></i>'
  end

  it "should generate icon in span" do 
    span_icon('btn', 'add').must_equal '<span class="btn"><i class="add"></i></span>'
  end

  it "should work with shorter name" do 
    si('btn', 'add').must_equal span_icon('btn', 'add')
  end

  it "should generate icon before text" do 
    icon_text('add', '+').must_equal '<span class="icon-text"><i class="add"></i>+</span>'
  end

  it "should work with shorter name" do 
    it('add', 'New page').must_equal icon_text('add', 'New page')
  end

  it "should work with shorter name" do 
    gt('add', 'New page').must_equal glyphicon_text('add', 'New page')
  end

  it "should extract text from html tags" do 
    extract('<div><i><i/><span>Apple iPhone</span></div>').must_equal 'Apple iPhone'
    extract('<div><i><i/><span>Apple iPhone</span></div>', truncate: 8).must_equal 'Apple...'
  end

  it "should generate true of false icon" do 
    true_false_icon(false).must_equal '<i class="glyphicon glyphicon-minus"></i>'
    true_false_icon(true).must_equal '<i class="glyphicon glyphicon-ok"></i>'
  end

  it "should generate current date" do 
    current_date.to_s.must_equal Time.zone.now.to_datetime.to_s
  end

  it "should generate bootstrap flash" do 
    self.stubs(:flash).returns(notice: 'Notice')
    bootstrap_flash.must_equal '<div id="alerts"><div class="alert fade in alert-success"><a class="close" data-dismiss="alert" href="#">x</a>Notice</div></div>'
    self.stubs(:flash).returns(alert: 'Alert')
    bootstrap_flash.must_equal '<div id="alerts"><div class="alert fade in alert-error alert-danger"><a class="close" data-dismiss="alert" href="#">x</a>Alert</div></div>'
  end

  it "shouldn't show anything" do
    google_analytics.must_be_nil
  end

  it "should show google analytics code" do
    google_analytics(123).must_include '123'
  end

  it "should return divisible" do
    divisible_by(4).must_equal %w(div-by-1 div-by-2 div-by-4)
  end

  it "should return divisible" do
    divisible_class(4).must_equal 'div-by-1 div-by-5'
  end
end