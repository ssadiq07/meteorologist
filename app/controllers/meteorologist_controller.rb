require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_geo = @street_address.tr!(" ", "+")
    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

#get lat/long
url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address_geo
raw_data = open(url).read
parsed_data = JSON.parse(raw_data)
@lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
@lng = parsed_data["results"][0]["geometry"]["location"]["lng"]

#do weather
url = "https://api.darksky.net/forecast/4253ad958611056c974ed2c703b9f2e9/#{@lat},#{@lng}/"
raw_data = open(url).read
parsed_data = JSON.parse(raw_data)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
