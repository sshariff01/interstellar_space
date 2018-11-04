class InactiveSubdomain
  def self.matches?(request)
    if Rails.env.production?
      !request.url.match(/^#{request.protocol}(.+\.)*(.+\..+\..+)$/).captures.first.present?
    else
      !request.url.match(/^#{request.protocol}(.+\.)*(.+\..+)$/).try(:captures).try(:first).present?
    end
  end
end
