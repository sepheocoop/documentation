# BUILDING

## Prerequisites

The prerequisites are defined in the `Gemfile`. These dependencies
need to be installed first. The configuration in `.bundle/config` makes
`bundle` install them local to this project.

    bundle install
	
Then you can run this Rakefile's tasks like this:

    bundle exec rake <task>

Where `<task>` is the task ID in question. 

## Building the stand-alone documents

The documents in `docs/` are stand-alone documents, meaning they
should not contain relative links to any of the other documents in
this repository.  This means they can be build as PDFs or some other
self-contained format and distributed independently.

To build the Asciidoc format documents as PDF documents (those ending
with the .adoc suffix), run:

   bundle exec rake pdf

The output of this goes into `/build/docs/`

Currently no other format but Asciidoc is supported - so anything
without a .adoc suffix won't be processed.
