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
      mermaid
      tables
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

    def mermaid
      fragment.css('pre[lang="mermaid"]').each do |pre|
        wrapper = Nokogiri::XML::Node.new('div', fragment)
        wrapper['class'] = 'mermaid-container'
        wrapper['data-controller'] = 'mermaid'

        loader = Nokogiri::XML::Node.new('div', fragment)
        loader['class'] = 'mermaid-loader js-only'
        loader['data-mermaid-target'] = 'loader'
        loader['aria-hidden'] = 'true'

        spinner = Nokogiri::XML::Node.new('span', fragment)
        spinner['class'] = 'loading loading-spinner loading-3xl text-primary'

        loader.add_child(spinner)

        diagram = Nokogiri::XML::Node.new('div', fragment)
        diagram['class'] = 'mermaid js-only'
        diagram['data-mermaid-target'] = 'diagram'
        diagram.content = pre.text.strip

        noscript = Nokogiri::XML::Node.new('noscript', fragment)

        alert = Nokogiri::XML::Node.new('div', fragment)
        alert['class'] = 'alert alert-error not-prose'

        icon = Nokogiri::XML::DocumentFragment.parse(helpers.lucide_icon('triangle-alert'))
        alert.add_child(icon)

        text = Nokogiri::XML::Node.new('span', fragment)
        text.content = 'JavaScript is required to load Mermaid graph'
        alert.add_child(text)

        noscript.add_child(alert)

        wrapper.add_child(noscript)
        wrapper.add_child(loader)
        wrapper.add_child(diagram)

        pre.replace(wrapper)
      end
    end

    def tables
      fragment.css('table').each do |table|
        wrapper = Nokogiri::XML::Node.new('div', fragment)
        wrapper['class'] = 'overflow-x-auto'

        table.replace(wrapper)
        wrapper.add_child(table)
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
