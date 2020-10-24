module GroupsHelper
  def email_search(search)
    return [] unless search
    User.where(['email LIKE ?', "%#{search}%"])
  end
end
