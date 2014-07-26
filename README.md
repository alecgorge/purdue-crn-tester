# README

RSS feeds to let you know if seats are available in classes at Purdue.

## Usage

```
npm install
npm start
```

## API

```
/:semester/crns/:crns.xml?only_available=[yes|no]
```

### Example

```
/Fall%202014/crns/69675,68634.xml?only_available=yes
```

### Example Output

```
<?xml version="1.0" encoding="UTF-8"?>
<rss xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:atom="http://www.w3.org/2005/Atom" version="2.0">
	<channel>
		<title><![CDATA[Seat availability for 69675, 68634 (Fall 2014)]]></title>
		<description><![CDATA[When this feed is request, it will give you the number of free seats in each CRN]]></description>
		<link>https://mypurdue.purdue.edu</link>
		<image>
			<url>http://www.purdue.edu/discoverypark/food/assets/images/the%20P.jpg</url>
			<title>Seat availability for 69675, 68634 (Fall 2014)</title>
			<link>https://mypurdue.purdue.edu</link>
		</image>
		<generator>Purdue CRN Tester by Alec Gorge</generator>
		<lastBuildDate>Sat, 26 Jul 2014 16:49:46 GMT</lastBuildDate>
		<atom:link href="http://purdue-crn-tester.app.alecgorge.com/Fall%202014/crns/69675,68634.xml" rel="self" type="application/rss+xml"/>
		<author><![CDATA[Alec Gorge]]></author>
		<pubDate>Sat, 26 Jul 2014 16:49:46 GMT</pubDate>
		<ttl>15</ttl>
		<item>
			<title><![CDATA[69675 — COM 21700 - Science Writing And Presentation]]></title>
			<description><![CDATA[<p>Seats available: <strong><large>NO</large></strong></p>

<h3>Seating</h3>
<ul>
<li>Max: 20</li>
<li>Occupied: 20</li>
<li>Available: 0</li>
</ul>

<p style="display:none"></p>]]></description>
			<link>https://selfservice.mypurdue.purdue.edu/prod/bwckschd.p_disp_detail_sched?term_in=201510&amp;crn_in=69675</link>
			<guid isPermaLink="false">201510-69675-1406393386282</guid>
			<dc:creator><![CDATA[Alec Gorge]]></dc:creator>
			<pubDate>Sat, 26 Jul 2014 16:49:46 GMT</pubDate>
		</item>
		<item>
			<title><![CDATA[68634 — COM 21700 - Science Writing And Presentation]]></title>
			<description><![CDATA[<p>Seats available: <strong><large>NO</large></strong></p>

<h3>Seating</h3>
<ul>
<li>Max: 20</li>
<li>Occupied: 20</li>
<li>Available: 0</li>
</ul>

<p style="display:none"></p>]]></description>
			<link>https://selfservice.mypurdue.purdue.edu/prod/bwckschd.p_disp_detail_sched?term_in=201510&amp;crn_in=68634</link>
			<guid isPermaLink="false">201510-68634-1406393386282</guid>
			<dc:creator><![CDATA[Alec Gorge]]></dc:creator>
			<pubDate>Sat, 26 Jul 2014 16:49:46 GMT</pubDate>
		</item>
	</channel>
</rss>
```
