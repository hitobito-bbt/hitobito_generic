class Person::DonationsController < CrudController
  include YearBasedPaging
  include Api::JsonPaging
  decorates :invoice

  self.nesting = [Group, Person]

  self.remember_params += [:description, :amount, :issued_at]
  self.permitted_attrs = [:description, :amount, :issued_at]

  before_render_index :year  # sets ivar used in view

  def create
    super(location: group_person_donations_path(parents.first, parents.last))
  end

  def destroy
    super(location: group_person_donations_path(parents.first, parents.last))
  end

  private

  def list_entries
    super.list
  end


end

