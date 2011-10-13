class Photo
  include Mongoid::Document

  field :image_file, type: String
  field :title, type: String

  field :referer, type: String
  field :appears_in, type: Array, default: []
  
  field :width, type: Integer
  field :height, type: Integer
  field :mean_color, type: Hash
  field :format, type: String
  
  field :md5, type: String

  mount_uploader :image, PhotoUploader

  index :md5, unique: true
  index :appears_in

  validates_presence_of :title, :image
  validates_uniqueness_of :md5

  before_save :save_image_properties, :calculate_mean_color
  before_validation :calculate_md5

  def save_image_properties
    img = Magick::Image.read(self.image.path).first
    self.width = img.columns
    self.height = img.rows
    self.format = self.image.file.extension
  end 

  def calculate_mean_color
    img = Magick::Image.read(self.image.path).first
    red = green = blue = 0
    img.each_pixel do |p, x, y|
      red += p.red
      green += p.green
      blue += p.blue
    end
    num_pixels = img.bounding_box.width * img.bounding_box.height
    self.mean_color = {
      red: red / num_pixels,
      green: green / num_pixels,
      blue: blue / num_pixels
    }
  end

  def calculate_md5
    require 'digest/md5'
    self.md5 = Digest::MD5.hexdigest(self.image.file.read)
  end
end