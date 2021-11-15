class ParsesController < ApplicationController 

    def index
        
    end

    def parse
        #url = "https://osu.ppy.sh/community/matches/#{params[:parse][:id]}"
        url = []
        unparsed_page = []
        parsed_page = []
        @json = []
        temp_parsed_page = 0
        k = 0
        # loop do
        #     if k >= 10
        #         url.push("https://osu.ppy.sh/community/matches/8930#{k}00")
        #     else
        #         url.push("https://osu.ppy.sh/community/matches/8930#{k}000")
        #     end
        #     unparsed_page.push(HTTParty.get(url[k]))
        #     temp_parsed_page = Nokogiri::HTML(unparsed_page[k])
        #     parsed_page.push(temp_parsed_page.css('script')[11])
        #     #@json.push(JSON.parse(parsed_page[k]))
        #     k = k + 1
        #     break if k == 99
        # end
        # for l in parsed_page
        #     @json.push(JSON.parse(l))
        # end
        # parsed_page = Nokogiri::HTML(unparsed_page)
        # parsed_page = parsed_page.css('script')[11]
        #@parsed_json = ActiveSupport::JSON.decode(@parsed_page)
        #parsed_page.gsub!(/\"/, '\'')
        #@json = JSON.parse(parsed_page)
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
        # for h in @json['events'] do
        #     if h.has_key? 'game'
        #         x += 1
        #         total_maps_played.append(h)
        #         for i in h['game']['scores']
        #             y += 1
        #             # if i.values.include? params[:user_id] --> z.B. 9146098
        #                # z += 1
        #                # @scores.append(i) # Scores werden hinzugefügt
        #             # end
        #         end
        #     end
        # end
        #Match.calculate_average_score(Match.find(params[:id], @scores))
    
    end

        #@average_score = @average_score / @scores.count
        # score = @json['events'][i]
                                                            #@json['events'][42]['game']['scores'][0]['score']
        #debugger

end
