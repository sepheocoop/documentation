# Rakefile for building documentation.
#
# See BUILDING.md

DIR = Pathname.new(__dir__)
BUILD_DIR = DIR + 'build'
GIT_PURL_BASE = 'https://github.com/sepheocoop/documentation/blob/'

autoload :FileUtils, 'fileutils'
require 'asciidoctor'
require 'asciidoctor/extensions'
require 'kramdown'

# Helper method, converts a path to a relative path
def rel(path, ref = pwd)
  path = Pathname.new(path) unless path.is_a? Pathname
  path = path.expand_path unless path.absolute?
  path.relative_path_from(ref).to_s
end

# Helper method to get the URL for a file given it's gitref and path
def source_url(git_ref, path)
  GIT_PURL_BASE + git_ref + '/' + path
end

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


desc 'Build the documents in docs/ as PDF format'
task :pdf do
  require 'asciidoctor-pdf'
  require 'kramdown/converter/pdf'
  output_dir = BUILD_DIR + 'docs'
  theme_file = DIR + 'pdf-theme.yml'
  git_ref = `git rev-parse HEAD`.chomp
  git_describe = `git describe --always --tags --dirty --abbrev=4`.chomp

  # Convert Asciidoc files
  Dir['docs/*.adoc', base: DIR.to_s].each do |file|
    warn "building #{file} -> #{rel BUILD_DIR + file} #{source_url git_ref, file}"
    
    Asciidoctor.convert_file(
      DIR+file,
      safe: :unsafe,
      backend: 'pdf',
      to_dir: rel(output_dir),
      mkdirs: true,
      attributes: {
        'pdf-theme' => rel(theme_file),
        'source-url' => source_url(git_ref, file),
        'git-describe' => git_describe,
      },
    )
  end

  # Convert Markdown files
  Dir['docs/*.md', base: DIR.to_s].each do |file|
    output_path = output_dir + file.sub(/[.]md$/,'.pdf')
    warn "building #{rel file} -> #{rel output_path}"
    
    doc = Kramdown::Document.new(IO.read file).to_pdf

    FileUtils.mkdir_p output_path.dirname # Just in case
    IO.write(output_path, doc)
  end
end
