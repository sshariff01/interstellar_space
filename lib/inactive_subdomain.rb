class InactiveSubdomain
  def self.matches?(request)
    !request.url.match(/^#{request.protocol}(.+\.)*(.+\..+)$/).captures.first.present?
  end
end
