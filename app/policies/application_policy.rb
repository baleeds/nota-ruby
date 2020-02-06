class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def logged_in?
    !user.guest?
  end

  def admin?
    user.admin?
  end
end
