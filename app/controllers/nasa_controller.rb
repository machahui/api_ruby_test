require 'faraday'
require 'json'

class NasaController < ApplicationController
  before_action :set_api_key, only: [:apod, :asteroid]

  def apod
    params = {
      api_key: @api_key,
      start_date: (Date.today - 7).to_s,
      end_date: Date.today.to_s,
    }
    response = Faraday.get(@api_url + '/planetary/apod',params)

    if response.status == 200
      data = JSON.parse(response.body)
      render json: data, status: :ok
    else
      render json: { error: 'Error al consumir el servicio' }, status: :unauthorized
    end

  end

  def asteroid
    params = {
      api_key: @api_key,
      start_date: (Date.today - 7).to_s,
      end_date: Date.today.to_s,
    }
    response = Faraday.get(@api_url + '/neo/rest/v1/feed',params)

    if response.status == 200
      data = JSON.parse(response.body)
      asteroids = []
      data['near_earth_objects'].each do |key, value|
        value.each do |item|
          estimated_diameter = ''
          if item['estimated_diameter']
            estimated_diameter = item['estimated_diameter']['meters']
          end
          asteroids.append(
            {
              id: item['id'],
              date: key,
              name: item['name'],
              estimated_diameter: estimated_diameter
            }
          )
        end
      end
      render json: asteroids, status: :ok
    else
      render json: { error: 'Error al consumir el servicio' }, status: :unauthorized
    end
  end

  private
  def set_api_key
    @api_key = '2poUvCAsJb2dVWoPkU94XvD5Fvzx9dF4qiJjar5d'
    @api_url = 'https://api.nasa.gov'
  end
end