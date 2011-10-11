class Photo
  include Mongoid::Document
  field :url, :type => String
  field :title, :type => String
  field :thumbnail, :type => String
  field :referer, :type => String
  field :width, :type => Integer
  field :height, :type => Integer
  field :format, :type => String
  field :mean_color, :type => String
  field :path, :type => String
  field :md5, :type => String
end
