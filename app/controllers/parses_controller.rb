class ParsesController < ApplicationController 

    def index
        
    end

    def matchRequest
        
    end

    def parse
        #url = "https://osu.ppy.sh/community/matches/#{params[:parse][:id]}"
        url = params[:url]
        # unparsed_apge = 
        # parsed_page = Nokogiri::HTML(unparsed_page)
        # parsed_page = parsed_page.css('script')[11]
        # @parsed_json = ActiveSupport::JSON.decode(@parsed_page)
        # parsed_page.gsub!(/\"/, '\'')
        # @json = JSON.parse(parsed_page)

        #Stehen lassen!
        # i = 0 
        # loop do 
        #     i+=1
        #     break if @json['events'][i].keys.include?('game')
        # end

        x = 0
        y = 0
        z = 0
        # total_maps_played = []
        # @scores = []
        # @average_score = 0
        for h in @json['events'] do
            if h.has_key? 'game'
                x += 1
                total_maps_played.append(h)
                for i in h['game']['scores']
                    y += 1
                    # if i.values.include? params[:user_id] --> z.B. 9146098
                       # z += 1
                       # @scores.append(i) # Scores werden hinzugefügt
                    # end
                end
            end
        end
        #Match.calculate_average_score(Match.find(params[:id], @scores))
    
    end

        #@average_score = @average_score / @scores.count
        # score = @json['events'][i]
                                                            #@json['events'][42]['game']['scores'][0]['score']
        #debugger
end
