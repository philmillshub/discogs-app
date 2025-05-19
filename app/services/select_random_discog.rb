require 'discogs-wrapper'

class SelectRandomDiscog < ApplicationService
  def initialize
    @wrapper = Discogs::Wrapper.new("MyDiscogsApp", user_token: ENV['DISCOGS_TOKEN'])
  end

  def call
    select_random_discog
  end

  private

  def select_random_discog
    {
      title: title,
      artist: artist,
      year: year,
      label: label,
      artwork_url: artwork_url
    }
  end

  def username
    ENV['DISCOGS_USERNAME']
  end

  def folder_id
    ENV['DISCOGS_FOLDER_ID'] || 1
  end

  def collection
    @collection ||= @wrapper.get_user_collection(username, { folder_id: folder_id })
  end

  def total_pages
    collection.pagination.pages
  end

  def random_page
    rand(1..total_pages)
  end

  def releases
    @wrapper.get_user_collection(username, { folder_id: folder_id, page: random_page }).releases
  end

  def random_release
    @random_release ||= releases.sample
  end

  def basic_info
    @basic_info ||= random_release.basic_information
  end

  def title
    basic_info.title
  end

  def artist
    basic_info.artists.first.name
  end  

  def year
    basic_info.year
  end

  def label
    basic_info.labels.first.name
  end

  def artwork_url
    basic_info.cover_image
  end
end
