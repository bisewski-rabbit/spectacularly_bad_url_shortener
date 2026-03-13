class UrlsController < ApplicationController
  def index
    @urls = Url.all
    render json: @urls.map(&:to_json)
  end

  def show
    @url = Url.find(params[:id])
    render json: @url.to_json
  end

  def create
    @url = Url.new(params.permit!)
    @url.created_by_ip = request.remote_ip

    if @url.save
      render json: @url.to_json, status: 201
    else
      render json: { error: @url.errors.full_messages }, status: 422
    end
  end

  def redirect
    @url = Url.find_by(short_code: params[:short_code])

    if @url
      @url.record_click!(request)
      redirect_to @url.original_url, allow_other_host: true
    else
      render plain: "Not found", status: 404
    end
  end

  def stats
    @url = Url.find_by!(short_code: params[:short_code])

    render json: {
      url: @url.original_url,
      clicks: @url.click_count || 0,
      clicks_by_country: @url.clicks_by_country,
      recent_clicks: @url.recent_clicks.map { |c|
        {
          at: c.created_at,
          country: c.country_name,
          referrer: c.referrer
        }
      },
      created_at: @url.created_at,
      created_by: @url.created_by_ip
    }
  rescue ActiveRecord::RecordNotFound
    render json: { error: "URL not found" }, status: 404
  end

  def popular
    @urls = Url.popular_urls
    render json: @urls.map { |u| { url: u.original_url, clicks: u.clicks.count } }
  end

  def destroy
    @url = Url.find(params[:id])
    @url.destroy
    head :no_content
  end
end
