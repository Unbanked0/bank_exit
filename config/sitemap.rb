SitemapGenerator::Sitemap.default_host = 'https://bank-exit.org'

SitemapGenerator::Sitemap.create do
  I18n.available_locales.each do |locale|
    I18n.with_locale(locale) do
      group(filename: "sitemap.#{locale}") do
        add maps_path, priority: 1, changefreq: 'daily'
        add faq_path, priority: 0.5, changefreq: 'monthly'
        add risks_path, priority: 0.7, changefreq: 'monthly'
        add media_path, priority: 1, changefreq: 'monthly'
        add local_groups_path, priority: 1, changefreq: 'monthly'
        add collective_path, priority: 1, changefreq: 'monthly'
        add statistics_path, priority: 1, changefreq: 'daily'
        add glossaries_path, priority: 1, changefreq: 'monthly'

        # Map merchants
        Merchant.available.find_each do |merchant|
          next if merchant.name.blank?

          add merchant_path(merchant), priority: 0.7, changefreq: 'weekly'
        end

        # Projects
        projects = Project.all
        projects.each do |project|
          next if project.identifier == 'map'

          add project_path(project.identifier), priority: 0.7, changefreq: 'monthly'
        end

        # Blogs
        add blogs_path, priority: 1, changefreq: 'monthly'

        blogs = Blog.all
        blogs.each do |blog|
          add blog_path(blog.identifier), priority: 0.7, changefreq: 'monthly'
        end

        # Tutorials
        add tutorials_path, priority: 1, changefreq: 'monthly'

        tutorials = Tutorial.all
        tutorials.each do |tutorial|
          add tutorial_path(tutorial.identifier), priority: 0.7, changefreq: 'monthly'
        end

        # Directories
        add directories_path, priority: 1, changefreq: 'monthly'

        Directory.enabled.each do |directory|
          add directory_path(directory), priority: 0.7, changefreq: 'monthly'
        end
      end
    end
  end
end
