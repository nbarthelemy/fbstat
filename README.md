
# Fantasy Baseball Stats

The following is an example application designed to aggregate fantasy baseball stats.

## Design Paradigm

Based on the given description, this did not seem like a CRUD based application to me. Users of the application would be looking to consume the data not update it. Therefore, I provided no ability to edit the data. My thought was that the data would be updated via some sort of process pulling from an external source ( FTP, RSS, Filesysem, etc.. ) which would untimately invalidate any caches.

The data that was provided for the exercise was incomplete. I chose to skip the inclusion of records without a first or last name, because that generally resulted in a nil player code which could not be generated in the standard format. The output from the seeding process denotes the records that were skipped with a reason, so the user has an ability to fix the record.

The description says there was a triple crown winner in 2012. After working through some debugging output and doing some research, I found that Miguel Cabrera won the triple crown in 2012 for the American League. However, based on the data and formulas provided in the exercise description league is not considered. If the entire major league was considered in the equasion, his triple crown win would be invalidated because Buster Posey has a batting average of .336 and Miguel Cabrera has a batting average of .33. I decided to resolve a league for each team and included it in my importer to deliver the correct results. I also found that winning the triple crown has a minimum at bat requirement of 502 to qualify which I represented in the code. This requirement was also not mentioned in the description.

Once the application is up and running in development, code coverage metrics are generated after the first test run. You can access the code covervage metrics by opening the /coverage/rspec/index.html in the root of the project.

All tests pass and all development was test-driven.

I noticed a specification to print things to STDOUT. I assumed the desire was to determine my ability to use Rails along with Ruby, so I created a web application based on Rails.


## Getting Started

Once you clone this application from github, run the following steps

* rake db:create
* rake db:migrate
* rake db:seed

## Next Steps

If I were to continue working on this application, here are the next steps I would take:

* Sanitize the data
	* Gather outside reference data for lookups, such as Team Name based on code
	* Normalize league data
	* Although I am generating player codes based on the current format, I didn't feel confident resolving conflicts ( Two users with the same code ), because there was a potential to have stats associated with one or the other. So I just skipped the second one to allow the correction of the data.
* Build out a data importer which utilizes an adapter pattern to speak to the data source to resolve and sanitize data
* Perform frontend page caching which is invalidated by the importation of new data