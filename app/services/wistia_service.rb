# frozen_string_literal: true

# Wistia related requests
class WistiaService < BaseService
  def initialize
    super() # call parent constructor without passing argument
    @response = nil
  end

  def video_detail(wistia_code = nil)
    video_url = ENV['WISTIA_BASE_URL'] + "v1/medias/#{wistia_code}?" +
                access_token.to_query
    res = RestClient.get(video_url)
    @response = JSON.parse(res)
  rescue StandardError => e
    errors(e.message)
  end

  def video_json
    {
      wistia_code: @response['hashed_id'],
      duration: @response['duration'].to_i.pretty_duration,
      thumbnail: new_url,
      file_name: @response['name']
    }
  end

  def new_url
    url = @response['thumbnail']['url']
    url && "#{url.split('?')[0]}?#{image_settings.to_query}" || ''
  end

  def image_settings
    {
      image_resize: '630x420',
      image_play_button: true,
      image_play_button_color: 'FF5CCDA0'
    }
  end

  def access_token
    {
      access_token: ENV['WISTIA_TOKEN']
    }
  end
end
