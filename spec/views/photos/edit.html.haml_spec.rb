require 'spec_helper'

describe "photos/edit.html.haml" do
  before(:each) do
    @photo = assign(:photo, stub_model(Photo,
      :url => "MyString",
      :title => "MyString",
      :thumbnail => "MyString",
      :referer => "MyString",
      :width => 1,
      :height => 1,
      :format => "MyString",
      :mean_color => "MyString",
      :path => "MyString",
      :md5 => "MyString"
    ))
  end

  it "renders the edit photo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => photos_path(@photo), :method => "post" do
      assert_select "input#photo_url", :name => "photo[url]"
      assert_select "input#photo_title", :name => "photo[title]"
      assert_select "input#photo_thumbnail", :name => "photo[thumbnail]"
      assert_select "input#photo_referer", :name => "photo[referer]"
      assert_select "input#photo_width", :name => "photo[width]"
      assert_select "input#photo_height", :name => "photo[height]"
      assert_select "input#photo_format", :name => "photo[format]"
      assert_select "input#photo_mean_color", :name => "photo[mean_color]"
      assert_select "input#photo_path", :name => "photo[path]"
      assert_select "input#photo_md5", :name => "photo[md5]"
    end
  end
end
