# Rakefile for building documentation.
#
# See BUILDING.md

MASTER_FILENAME='overview.adoc'
BUILD_DIR='build'
autoload :FileUtils, 'fileutils'
require 'asciidoctor'
require 'asciidoctor/extensions'

# Adapted from https://discuss.asciidoctor.org/Paragraph-numbering-tp3697p3890.html
class NumberParagraphsTreeprocessor < Asciidoctor::Extensions::Treeprocessor
  def process document
    document.find_by(context: :paragraph).each_with_index do |p, idx|
      pnum = idx + 1
      # number paragraph using title
      # p.title = %(#{pnum}.)

      # or insert number into paragraph
      p.lines.first.prepend %([[pg-#{pnum}]] <#{pnum}>. )
    end
  end
end

#  Uncomment to enable paragraph numbering
#Asciidoctor::Extensions.register do
#  treeprocessor NumberParagraphsTreeprocessor
#end


desc 'Build the PDF format'
task :pdf do
  require 'asciidoctor-pdf'
  Asciidoctor.convert_file MASTER_FILENAME,
    safe: :unsafe,
    backend: 'pdf',
    to_dir: BUILD_DIR,
    mkdirs: true
end
