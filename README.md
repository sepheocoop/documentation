# Sepheo Documentation

This repository contains internal Sepheo documentation, such as
articles of association, mission statements, and more generally other
guides, process descriptions and planning documents intended for
members rather than the general public.

## Stand-alone documents

The directory [docs/](docs/) contains stand-alone documents, meaning
documents which are meant to be self-contained and printable, and
therefore can't contain relative hypertext links to other documents in
this repository (although they might contain include links or other
kinds of links intended to bring in assets stored in the repository,
such as images).

See [BUILDING.md](BUILDING.md) for more information about generating
printable versions of these documents.

The intention is that important legal and formal documents be stored
here, under version control, and that they get updated using GitHub's
facility for submitting modifications via pull-requests. This allows
changes to be attributed and audited in a fine-grained way, like
source code, whilst still allowing printable versions to be
obtained. This is considered a better method than using Microsoft Word
and its change tracking feature. As a bonus, all files in this
repository then get versioned together as a unit.

## Wiki-like documents

However, the other files in the repository, both Markdown and Asciidoc
format, *may* include relative links to other documents, allowing them
to function a bit like a wiki when viewed on GitHub. By default,
GitHub's website renders these formats into hypertext when browsing a
project, with no extra machinery or processing. For examples of this
in Markdown, see the text source of this document. For examples in
Asciidoc, use the
[`link:`](https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/#links)
macro, e.g. `link:some/relative/path.adoc[]`.
