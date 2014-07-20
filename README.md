[![Stories in Ready](https://badge.waffle.io/mivok/markdownlint.png?label=ready&title=Ready)](https://waffle.io/mivok/markdownlint)
[![Travis build status](http://api.travis-ci.org/mivok/markdownlint.svg)](https://travis-ci.org/mivok/markdownlint)

# Markdown lint tool

## What is Markdownlint?

Generally, when making a markdown document, there is only one way to check that you did everything correctly: run the document through a markdown viewer or renderer and make sure it looks right. Looking at the rendered document manually means it's easy to miss problems, and markdown doesn't have a syntax checker to help you out.

Markdownlint is an attempt to check a markdown document for common problems, letting you quickly check one or many documents at once. There are a few general types of things that markdownlint checks for:

* Syntax errors (e.g. you got the link syntax mixed up and used the wrong brackets)
* Style rules (e.g. adherence to www.cirosantilli.com/markdown-styleguide)
* Constructs that may break in some markdown parsers or flavors

## Styles

When checking a document, you almost certainly don't want to enable all rules markdownlint checks for. In fact, some of the rules are contradictory! Which set of rules you want to enable will depend on which parser you use and if you want your documents to adhere to a specific style. This is where style files come in. Style files specify which rules to enable.

## Creating Rules

    rule "MD000", "Rule name" do
      check do |doc|
        # check code goes here
        # return a list of line numbers that break the rule, or an empty list
        # (or nil) if there are no problems.
      end
    end

* doc - Object containing a representation of the markdown document
* doc.lines - The raw markdown file as an array of lines
  * You can look up a line given an element with doc.element_lines
* doc.parsed - Kramdown internal representation of the doc
* doc.elements - All elements in the doc
* element.options - hash containing:
  * `:type` - symbol describing the type of element
  * `:location` - line number of element
  * other stuff that varies by element

## Contributing

1. Fork it ( http://github.com/mivok/mdl/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
