class BookPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.librarian? || user.admin?
  end

  def update?
    user.librarian? || user.admin?
  end

  def destroy?
    user.admin?
  end
end