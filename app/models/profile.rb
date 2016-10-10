class Profile < ActiveRecord::Base
  belongs_to :user

  validate :names_not_both_null
  validate :no_male_sue
  validates :gender, inclusion: { in: %w(male female)}

  def names_not_both_null
  	if self.first_name.nil? and self.last_name.nil?
  		errors.add(:last_name, "cannot be both null")
  	end
  end

  def no_male_sue
  	if gender == "male" and first_name == "Sue"
  		errors.add(:first_name, "cannot be 'Sue' if you are a man ;-)")
  	end
  end

  def self.get_all_profiles(minage, maxage)
  	Profile.where("birth_year BETWEEN :min_age AND :max_age", min_age: minage, max_age: maxage).order("birth_year ASC")
  end
end
