class ActiveSubdomain
  def self.matches?(request)
    if Rails.env.production?
      request.url.match(/^#{request.protocol}(.+\.)*(.+\..+\..+)$/).captures.first.present?
    else
      request.url.match(/^#{request.protocol}(.+\.)*(.+\..+)$/).captures.first.present?
    end
  end
end
