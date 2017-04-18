require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords

    @street_address = params[:user_street_address]
    @street_address_geo = @street_address.tr!(" ", "+")

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
#url = "http://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA"
url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address_geo
raw_data = open(url).read
parsed_data = JSON.parse(raw_data)
latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    @latitude = latitude

    @longitude = longitude

    render("geocoding/street_to_coords.html.erb")
  end
end
