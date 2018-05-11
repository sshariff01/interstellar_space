class ActiveSubdomain
  def self.matches? request
    if request.subdomain.present?
      true
    else
      false
    end
  end
end
