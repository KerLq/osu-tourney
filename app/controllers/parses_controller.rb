class ParsesController < ApplicationController 

    def index

    end
    def parse
        url = "https://osu.ppy.sh/community/matches/#{params[:parse][:id]}"
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
        y = 0
        z = 0
        total_games_played = []
        @scores = []
        @average_score = 0
        for h in @json['events'] do
            if h.has_key? 'game'
                x += 1
                total_games_played.append(h)
                for i in h['game']['scores']
                    y += 1
                    #if i.values.include? 9146098 # USER SCORE
                       # z += 1
                       # @scores.append(i)
                    #end
                end
            end
        end
        for j in @scores
            j.slice!("user_id", "accuracy", "mods", "score", "max_combo")
            @average_score += j['score']
        end
        #@average_score = @average_score / @scores.count
        # score = @json['events'][i]
                                                            #@json['events'][42]['game']['scores'][0]['score']
        #debugger
    end

end