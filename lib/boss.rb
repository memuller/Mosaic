class Boss
	attr_accessor :key, :secret, :consumer, :client
	attr_accessor :results, :market, :format, :service, :num_results, :response_code, :total_results


	def self.config
		path = "#{Rails.root}/config/boss.yml"
		config = YAML::load(File.open(path))
		[config['consumer_key'], config['consumer_secret']]
	end
	def initialize key, secret, *args
		@key = key
		@secret = secret 
		@format = 'json'
		@market = 'pt-rb'
		@service = 'images'
		@num_results = 10
		@results = [ ]
		@consumer = OAuth::Consumer.new key, secret, site: 'http://yboss.yahooapis.com'
		@client = OAuth::AccessToken.new @consumer
	end

	def search(query, *args)
		query = URI.encode(query)
		step_size = 35 > @num_results ? 35 : @num_results
		(0..@num_results).step(step_size) do |i|
			url = "/ysearch/#{service}?q=#{query}&format=#{@format}"
			url += "&count=#{step_size}&start=#{i}"
			request = @client.get(url)
			body = JSON.parse(request.body).first.last
			@response_code = body['responsecode']
			@total_results = body[@service]['totalresults']
			@result = body[@service]['results']
		end
		@result
	end

end