port		= 1984

express		= require 'express'
morgan 		= require 'morgan'
rss 		= require 'rss'

purdue_api  = require './purdue_api'

app = express()
app.use morgan('dev')

feed_options = (semester, crns) ->
	crns_txt = crns.join ', '
	return {
		title: "Seat availability for #{crns_txt} (#{semester})"
		description: 'When this feed is request, it will give you the number of free seats in each CRN'
		generator: 'Purdue CRN Tester by Alec Gorge'
		feed_url: "http://purdue-crn-tester.app.alecgorge.com/#{encodeURIComponent(semester)}/crns/#{crns.join(',')}.xml"
		image_url: 'http://www.purdue.edu/discoverypark/food/assets/images/the%20P.jpg'
		site_url: 'https://mypurdue.purdue.edu'
		author: 'Alec Gorge'
		ttl: 15
		pubDate: new Date
	}

app.get "/:semester/crns/:crns.xml", (req, res) ->
	crns = req.param('crns').trim().split(',').map((v) -> v.trim())
	sem  = req.param 'semester'

	only_available = req.param 'only_available'
	only_available = ['no', '0', 'false'].indexOf(only_available) is -1

	res.header 'Content-Type', 'application/rss+xml'

	if crns.length is 0
		res.send 400
		return

	feed = new rss feed_options(sem, crns)

	purdue_api.seating_details sem, crns, (err, resps) ->
		for cls in resps
			if only_available and cls.seats.available is 0
				continue

			feed.item cls.rss()

		res.send feed.xml '\t'

port = process.env.PORT or port
console.log "Listening on http://localhost:#{port}/"
app.listen port
