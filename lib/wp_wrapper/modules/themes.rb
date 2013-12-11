module WpWrapper
  module Modules
    
    module Themes
    
      def activate_theme(theme_identifier = 'twentytwelve')
        success                     =   false
        
        if (login)
          activation_link           =   nil
          themes_page               =   self.mechanize_client.open_url(get_url(:themes))
          
          if (themes_page)
            available_theme_links   =   themes_page.parser.css("div#availablethemes div.available-theme a.activatelink")
            regex                   =   Regexp.new("stylesheet=#{theme_identifier}", Regexp::IGNORECASE)
        
            available_theme_links.each do |link|
              href = link["href"]
          
              if (regex.match(href))
                activation_link     =   href
                break
              end
            end if (available_theme_links && available_theme_links.any?)
        
            if (activation_link && activation_link.present?)
              url                   =   "#{get_url(:admin)}/#{activation_link}"
              self.mechanize_client.open_url(url)
              puts "#{Time.now}: Url: #{self.url}. Theme '#{theme_identifier}' has been activated!"
              success               =   true
            else
              puts "#{Time.now}: Url: #{self.url}. Couldn't find the theme #{theme_identifier}'s activation-link."
            end
          end
        end
      
        return success
      end

    end
    
  end
end