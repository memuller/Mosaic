load 'lib/boss.rb'
namespace :boss do
	namespace :search do
		require 'yaml'
		desc "Makes a BOSS image search and store results"
		task :images, [:query, :num_results] => :environment do |task, args|
			boss = Boss.new(*Boss.config)
			boss.num_results = args[:num_results].to_i
			results = boss.search args[:query]
			results.each do |obj|
				photo = Photo.new title: obj['title'], 
					referer: obj['refererurl'], 
					remote_image_url: obj['url']
				unless photo.valid?
					photo = Photo.where(md5: photo.md5).first
				end
				photo.appears_in << args[:query] unless photo.appears_in.include? args[:query]
				photo.save!
			end
		end
	end
end