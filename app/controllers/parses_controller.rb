class ParsesController < ApplicationController 
    def parse 
        url = "https://osu.ppy.sh/community/matches/92550524"
        unparsed_page = HTTParty.get(url)
        parsed_page = Nokogiri::HTML(unparsed_page)
        parsed_page = parsed_page.css('script')[11]
        #@parsed_json = ActiveSupport::JSON.decode(@parsed_page)
        #parsed_page.gsub!(/\"/, '\'')
        @json = JSON.parse(parsed_page)
        
        # i = 0
        # loop do 
        #     i+=1
        #     break if @json['events'][i].keys.include?('game')
        # end

        x = 0
        scores = {}
        for h in @json['events'] do
            if h.has_key? 'game'
                x += 1
            end
        end
        # score = @json['events'][i]
                                                            #@json['events'][42]['game']['scores'][0]['score']
        debugger
    end

end