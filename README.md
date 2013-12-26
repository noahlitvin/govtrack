# GovTrack Gem
An unofficial Ruby wrapper for the [GovTrack API](http://www.govtrack.us/developers/api). You must agree to the surprisingly brief and readable [license terms](http://www.govtrack.us/developers/license) before using.

This README describes how to use this gem with version 2 of the GovTrack API.

## Installation

    gem install govtrack

Then ```require 'govtrack'``` and you're good to go.

## Usage

GovTrack data is supplied through various find methods:

```ruby
sopa = GovTrack::Bill.find_by_id(71392) #Find SOPA with a GovTrack ID...
al = GovTrack::Person.find(lastname: 'Franken').first #...Al Franken with a hash of parameters...
john = GovTrack::Person.find_by_gender_and_lastname('male','McCain').first #...or John McCain with an ActiveRecord-style dynamic finder!

#Let's see if SOPA's sponsor is older than Al Franken.
sopa.sponsor.birthday < al.birthday
=> true

#Is he older than John McCain?
sopa.sponsor.birthday < john.birthday
=> false
```

**Not all fields can be used in a query.** Some fields support [Django-style filters](https://docs.djangoproject.com/en/dev/ref/models/querysets/#field-lookups) and some can span relationships. Refer to the [GovTrack Data API Documentation](http://www.govtrack.us/developers/api) for details. 

### Pagination
By default, the API returns data in arrays of 20. You can adjust this amount and move through the results by setting ```:limit``` and ```:offset``` in your query. Alternatively, call ```.find``` with a block to iterate through all of the results.

```ruby
#Returns the titles of every bill currently introduced to the 112th Congress.
GovTrack::Bill.find(current_status: 'introduced', congress: 112) { |bill| bill.title }
```

## Examples

**See how Ron Paul and Dennis Kucinich voted on 'H.R. 3590: Patient Protection and Affordable Care Act':**

```ruby
obamacare = GovTrack::Bill.find_by_congress_and_bill_type_and_number(111,:house_bill,3590)
recent_obamacare_vote = GovTrack::Vote.find(related_bill: obamacare.id, order_by: "-created").first

ron = GovTrack::Person.find_by_lastname('Paul').last
ron_vote = GovTrack::VoteVoter.find(vote: recent_obamacare_vote, person: ron)
"#{ron.nickname} #{ron.lastname} voted '#{ron_vote.vote_direction}' on '#{obamacare.title}'."
=> "Ronald Paul voted 'No' on 'H.R. 3590 (111th): Patient Protection and Afforble Care Act'."

dennis = GovTrack::Person.find_by_lastname('Kucinich').first
dennis_vote = GovTrack::VoteVoter.find(vote: recent_obamacare_vote, person: dennis)
"#{dennis.firstname} #{dennis.lastname} voted '#{dennis_vote.vote_direction}' on '#{obamacare.title}'."
=> "Dennis Kucinich voted 'Aye' on 'H.R. 3590 (111th): Patient Protection and Affordble Care Act'."
```

**List the female members of congress who abstained from voting on 'H.R. 3: No Taxpayer Funding for Abortion Act':**

```ruby
hr3 = GovTrack::Bill.find_by_congress_and_bill_type_and_number(112,:house_bill,3)
recent_hr3_vote = GovTrack::Vote.find(related_bill: hr3.id, order_by: "-created").first
GovTrack::VoteVoter.find(vote: recent_hr3_vote) { |vote_voter|
  puts vote_voter.person.name if vote_voter.option['value'] == 'Not Voting' && vote_voter.person.gender == 'female'
}
=> "Rep. Gabrielle Giffords [D-AZ8, 2007-2012]"
=> "Rep. Jo Ann Emerson [R-MO8]"
```

## Tips

* If you're searching for a particular bill by its number, include a ```congress``` and ```bill_type``` in your query as well.
* There will often be more than one vote related to a bill.
* Depending on your application, consider using GovTrack's [Bulk Raw Data](http://www.govtrack.us/developers/data) instead.

## Copyright

Copyright (c) 2012 Noah Litvin. See [LICENSE](https://github.com/noahlitvin/govtrack/blob/master/LICENSE.md) for details.