def color_difference(rgb1, rgb2)
	red, green, blue = rgb1['red'] - rgb2['red'], rgb1['green'] - rgb2['green'], rgb1['blue'] - rgb2['blue']
	Math.sqrt( (red * red) + (green * green) + (blue * blue) )
end

def match_pixel(pixel)
	photos = Photo.all
	diffs = photos.collect do |photo|
		color_difference pixel, photo.mean_color 
	end
	photos[diffs.index(diffs.min)]
end

desc 'Builds a mosaic'
task :mosaic, [:image_md5, :tile_width, :tile_height] => :environment do |task, args|
	source_width = 100
	source = Photo.where(md5: args[:image_md5]).first
	source = Magick::Image.read(source.image.small.file.path).first
	source.resize_to_fit! source_width, (source.rows/source.columns) * source_width
	source_pixels = []
	source.each_pixel do |pixel, x, y|
		source_pixels << { 'red' => pixel.red, 'green' => pixel.green, 'blue' => pixel.blue }
	end

	mosaic_images = Magick::ImageList.new
	tile = Magick::Rectangle.new(args[:tile_width].to_i, args[:tile_height].to_i, 0, 0)
	i = 0
	source.rows.times do |row|
		source.columns.times do |col|
			photo = match_pixel(source_pixels[i])
			photo = Magick::Image.read(photo.image.small.file.path).first
			mosaic_images << photo.crop_resized!(args[:tile_width].to_i, args[:tile_height].to_i)
			tile.x = col * mosaic_images.columns
			tile.y = row * mosaic_images.rows
			mosaic_images.page = tile
			i += 1
		end
	end

	mosaic = mosaic_images.mosaic
	mosaic.write("mosaic_#{args[:image_md5]}.jpg")
end