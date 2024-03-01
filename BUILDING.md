# BUILDING

## Prerequisites

The prerequisites are defined in the `Gemfile`. These dependencies
need to be installed first. The configuration in `.bundle/config` makes
`bundle` install them local to this project.

    bundle install
	
Then you can run this Rakefile's tasks like this:

    bundle exec rake <task>

Where `<task>` is the task ID in question. Or more explicitly, for the PDF documents:

   bundle exec rake pdf
   
The output of the pdf task goes into `/build/`
