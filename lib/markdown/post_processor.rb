require 'nokogiri'

module Markdown
  class PostProcessor
    ANCHOR_ATTRIBUTES_TO_REMOVE = %w[
      aria-label
      data-heading-content
      target
      rel
    ].freeze

    def self.call(fragment)
      new(fragment).call
    end

    def initialize(fragment)
      @fragment = fragment
    end

    def call
      external_links
      admonitions
      headings

      @fragment
    end

    private

    attr_reader :fragment

    def external_links
      fragment.css('a:not(.anchor)').each do |link|
        link['target'] = '_blank'
        link['rel'] = 'noopener noreferrer'
      end
    end

    def admonitions
      fragment.css('aside.admonition').each do |aside|
        aside['class'] = [
          aside['class'],
          'not-prose'
        ].compact.join(' ')
      end
    end

    def headings
      fragment.css('h2, h3, h4, h5, h6').each do |heading|
        anchor = heading.at_css('> a.anchor')
        next unless anchor

        clean_anchor(anchor)

        heading.children.to_a.each do |child|
          next if child == anchor

          anchor.add_child(child.unlink)
        end

        anchor.add_child(anchor_icon)

        heading.add_child(anchor.unlink)
      end
    end

    def clean_anchor(anchor)
      ANCHOR_ATTRIBUTES_TO_REMOVE.each do |attribute|
        anchor.remove_attribute(attribute)
      end

      anchor['data-turbo'] = 'false'
    end

    def anchor_icon
      span = Nokogiri::XML::Node.new('span', fragment)
      span['class'] = 'anchor-icon'

      span << Nokogiri::XML::DocumentFragment.parse(
        helpers.lucide_icon('link')
      )

      span
    end

    def helpers
      ApplicationController.helpers
    end
  end
end
