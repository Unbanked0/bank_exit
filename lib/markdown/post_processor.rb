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
      table_of_contents
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

    def table_of_contents
      paragraph = fragment.css('p').find do |p|
        p.text.strip == '{{toc}}'
      end

      return unless paragraph

      paragraph.replace(build_table_of_contents)
    end

    def build_table_of_contents
      nav = Nokogiri::XML::Node.new('nav', fragment)
      nav['class'] = 'table-of-contents not-prose'

      label = I18n.t('.table_of_contents')
      nav['aria-label'] = label

      headings = fragment.css('h2, h3, h4')

      root_list = Nokogiri::XML::Node.new('ul', fragment)
      root_list['class'] = 'menu'

      root_item = Nokogiri::XML::Node.new('li', fragment)

      title = Nokogiri::XML::Node.new('p', fragment)
      title['class'] = 'menu-title'
      title.content = label

      root_item.add_child(title)

      content_list = Nokogiri::XML::Node.new('ul', fragment)
      root_item.add_child(content_list)

      root_list.add_child(root_item)

      stack = [[1, content_list]]

      headings.each_with_index do |heading, index|
        level = heading.name.delete_prefix('h').to_i

        stack.pop while stack.last[0] >= level

        parent_list = stack.last[1]

        heading_anchor = heading.at_css('> a.anchor')
        next unless heading_anchor

        li = Nokogiri::XML::Node.new('li', fragment)

        link = Nokogiri::XML::Node.new('a', fragment)
        link['href'] = heading_anchor['href']
        link['data-turbo'] = 'false'
        link.content = heading.text.strip

        li.add_child(link)
        parent_list.add_child(li)

        next_heading = headings[index + 1]

        next_level = (next_heading.name.delete_prefix('h').to_i if next_heading)

        next unless next_level && next_level > level

        child_list = Nokogiri::XML::Node.new('ul', fragment)

        li.add_child(child_list)

        stack << [level, child_list]
      end

      nav.add_child(root_list)

      nav
    end

    def headings
      fragment.css('h2, h3, h4, h5, h6').each do |heading|
        anchor = heading.at_css('> a.anchor')
        next unless anchor

        anchor.unlink
        clean_anchor(anchor)
        anchor.content = '#'

        heading.children.first&.add_previous_sibling(anchor)
      end
    end

    def clean_anchor(anchor)
      ANCHOR_ATTRIBUTES_TO_REMOVE.each do |attribute|
        anchor.remove_attribute(attribute)
      end

      anchor['data-turbo'] = 'false'
    end

    def helpers
      ApplicationController.helpers
    end
  end
end
