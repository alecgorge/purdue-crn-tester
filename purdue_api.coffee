
request = require 'request'
cheerio = require 'cheerio'
async   = require 'async'

class PurdueAPIResponse
	@details_url: (term_in, crn_in) ->
		return "https://selfservice.mypurdue.purdue.edu/prod/bwckschd.p_disp_detail_sched?term_in=#{term_in}&crn_in=#{crn_in}"

	constructor: (@term, @class_name, @crn, @class_identifier, seats_max, seats_occupied, seats_free) ->
		@seats =
			max: seats_max
			occupied: seats_occupied
			available: seats_free

	rss: () ->
		are_seats_available = if @seats.available > 0 then " - SEATS AVAILABLE" else ""
		bool_are_seats_available = if @seats.available > 0 then "YES" else "NO"
		seats_available_tag = if @seats.available > 0 then "SEATS_AVAILABLE_TAG" else ""
		return {
			title: "#{@crn} — #{@class_identifier}#{are_seats_available} - #{@class_name}"
			description: """<p>Seats available: <strong><large>#{bool_are_seats_available}</large></strong></p>
			
			<h3>Seating</h3>
			<ul>
			<li>Max: #{@seats.max}</li>
			<li>Occupied: #{@seats.occupied}</li>
			<li>Available: #{@seats.available}</li>
			</ul>

			<p style="display:none">#{seats_available_tag}</p>
			""",
			url: PurdueAPIResponse.details_url @term, @crn
			guid: @term + "-" + @crn + "-" + Date.now()
			date: new Date
		}

semester_cache = {}

###
<OPTION VALUE="200830">Summer 2008
<OPTION VALUE="200820">Spring 2008
###
build_semester_cache = () ->
	str_to_term_url = "https://selfservice.mypurdue.purdue.edu/prod/bwckctlg.p_disp_dyn_ctlg"

	re = /<OPTION VALUE="(\d{6})">(.*)$/mg
	request str_to_term_url, (err, res, body) ->
		while match = re.exec body
			semester_cache[match[2]] = match[1]

		console.log "Cached #{Object.keys(semester_cache).length} semester names"

sel_class_info = 'table[summary="This table is used to present the detailed class information."] .ddlabel'
sel_seating = 'table[summary="This layout table is used to present the seating numbers."] td'
details_single = (term_in, crn_in, cb) ->
	request PurdueAPIResponse.details_url(term_in, crn_in), (err, res, body) ->
		return cb(err, null) if err

		$ = cheerio.load body

		# Organic Chemistry Laboratory - 66830 - CHM 25601 - 013
		[class_name, crn, class_identifier] = $(sel_class_info).text().trim().split " - "

		[seats_max, seats_occupied, seats_free] = $(sel_seating).slice(1, 4).map (i, el) -> parseInt $(el).text().trim()

		cb null, new PurdueAPIResponse term_in, class_name, crn_in, class_identifier, seats_max, seats_occupied, seats_free

seating_details = (semester_common_name, crns, cb) ->
	term_in = semester_cache[semester_common_name]

	if not term_in
		cb "Semester not found! Options: " + Object.keys(semester_cache).join(", "), null
		return

	async.map crns, ((crn_in, cfb) -> details_single(term_in, crn_in, cfb)), (err, result) ->
		cb err, result

build_semester_cache()
setTimeout build_semester_cache, 1000 * 60 * 60 * 24

module.exports = exports = {
	seating_details: seating_details
}
