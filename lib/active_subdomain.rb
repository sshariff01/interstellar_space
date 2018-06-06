class ActiveSubdomain
  def self.matches?(request)
    if request.url.match(/^#{request.protocol}(.+\.)*(.+\..+)$/).captures.first.present?
      true
    else
      false
    end
  end
end
