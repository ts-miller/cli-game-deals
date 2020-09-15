class Cli

    def call
        welcome_prompt
        create_deals
        menu
        goodbye
        exit
    end

    def welcome_prompt
        line
        puts " _________                            ________            ______       "
        puts " __  ____/_____ _______ ________      ___  __ \\__________ ___  /_______"
        puts " _  / __ _  __ `/_  __ `__ \\  _ \\     __  / / /  _ \\  __ `/_  /__  ___/"
        puts " / /_/ / / /_/ /_  / / / / /  __/     _  /_/ //  __/ /_/ /_  / _(__  ) "
        puts " \\____/  \\__,_/ /_/ /_/ /_/\\___/      /_____/ \\___/\\__,_/ /_/  /____/  "
        puts
        line
        puts "Welcome to Cheapshark Game Deals!"
        puts "For more deals go to cheapshark.com"
        puts "Press 'any key' to get deals!"
        line
        STDIN.getch
        puts "Fetchin' dem deals..."
    end

    def line
        puts "----------------------------------------------------------------------"
    end

    def create_deals
        deals = GetDeals.parse
        deals.each do |deal|
            Deal.new(deal)
        end
    end

    def menu
        display_deals
        menu_key

        input = gets.strip

        if input.to_i.between?(1, Deal.all.count)
            display_deal_info(input.to_i-1)
            line
            puts "Copy URL into browser for purchase page."
            puts "Type 'deals' to return to deal list."
            puts "Type 'exit' to leave."
            line
            input = gets.strip
            second_menu_layer(input)
        elsif input == "exit"
            goodbye
            exit
        elsif input == "next"
            puts "Loading more deals..."
            next_page
        elsif input == 'back'
            puts "Going back yo..."
            previous_page
        else
            puts "Uhh, what are you saying?"
            menu
        end
    end

    def display_deals
        Deal.all.each.with_index do |deal, index|
            puts "#{index + 1}. #{deal.title} --$#{colorize(deal)} // Reg:$#{deal.normalPrice}"
        end
    end

    def colorize(deal)
        if (deal.salePrice.to_f / deal.normalPrice.to_f) <= 0.15
            deal.salePrice.red
        elsif (deal.salePrice.to_f / deal.normalPrice.to_f) <= 0.25
            deal.salePrice.magenta
        elsif (deal.salePrice.to_f / deal.normalPrice.to_f) <= 0.35
            deal.salePrice.blue
        else
            deal.salePrice
        end
    end

    def menu_key
        line
        puts "Page #{GetDeals.page + 1}"
        line
        print ">85% off".red, " // ", ">75% off".magenta, " // ", ">65% off".blue
        puts
        puts "Deals are ranked by 'Deal Rating' from highest to lowest."
        puts "Enter the number of the deal to get more info."
        puts "Type 'next' to go to the next page."
        puts "Type 'back' to go to the previous page"
        puts "Type 'exit' to leave."
        line
    end

    def display_deal_info(index)
        print "Title: ".blue, "#{Deal.all[index].title}\n"
        print "Price: ".light_blue, "$#{colorize(Deal.all[index])}\n"
        print "Normal Price: ".cyan, "$#{Deal.all[index].normalPrice} -- #{Deal.all[index].savings.to_i.round(2)}% savings\n"
        print "Steam Rating: ".light_green, "#{Deal.all[index].steamRatingPercent}% -- #{Deal.all[index].steamRatingText}\n"
        print "Deal Rating: ".yellow, "#{Deal.all[index].dealRating}\n"
        print "URL: ".light_yellow, "https://www.cheapshark.com/redirect?dealID=#{Deal.all[index].dealID}\n"
    end

    def second_menu_layer(input)
        case input
        when 'deals'
            menu
        when 'exit'
            goodbye
            exit
        else
            puts "Invalid input. Try again!!"
            input = gets.strip
            second_menu_layer(input)
        end
    end

    def next_page
        GetDeals.add_page
        Deal.all.clear
        create_deals
        menu
    end

    def previous_page
        if GetDeals.page > 0
            GetDeals.subtract_page
        end
        Deal.all.clear
        create_deals
        menu
    end
    
    def goodbye
        puts "Thanks for looking. See you later!"
    end
end