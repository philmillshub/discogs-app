class RecordsController < ApplicationController
  require 'ostruct'

  def suggest
    # Initialize Discogs client
    discogs = Discogs::Wrapper.new("DiscogsSuggestor", user_token: ENV['DISCOGS_TOKEN'])
    
    # Get a random record (you'll need to implement this logic)
    record = OpenStruct.new(get_random_record(discogs))
    
    # Format the response for Siri
    response = {
      message: "Here's a record you might like: #{record.title} by #{record.artist}. It was released in #{record.year} on #{record.label}.",
      artwork_url: record.artwork_url
    }
    
    render json: response
  end
  
  private
  
  def get_random_record(discogs)
    SelectRandomDiscog.call
  end
end

