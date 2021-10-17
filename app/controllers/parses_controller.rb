class ParsesController < ApplicationController 
    def parse 
        url = "https://osu.ppy.sh/community/matches/89309929"
        @unparsed_page = HTTParty.get(url)
        parsed_page = Nokogiri::HTML(@unparsed_page)
        parsed_page = parsed_page.css('script')[11]
        #@parsed_json = ActiveSupport::JSON.decode(@parsed_page)
        #parsed_page.gsub!(/\"/, '\'')
        parsed_page = JSON.parse(parsed_page)
        debugger
    end

end