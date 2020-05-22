
class DonationAbility < AbilityDsl::Base

  include AbilityDsl::Constraints::Group

  on(Donation) do
    permission(:any).may(:manage).her_own
    permission(:finance).may(:manage).in_same_layer
  end


  def her_own
    subject.person == user
  end

  private

  def group
    subject.person.layer_group
  end
end

