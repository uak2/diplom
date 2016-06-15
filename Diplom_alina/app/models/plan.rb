class Plan < ActiveRecord::Base
  has_many :student_periods
  belongs_to :speciality

	def change_display(plan)
		result=['План обучения']
		result << ['Изменениа специальность', self.speciality.name, plan.speciality.name] if plan.speciality_id != self.speciality_id
		result << ['Изменениа специализация', self.specialization, plan.specialization] if plan.specialization != self.specialization
		result << ['Измененно кол-во месяцев обучения', self.count_month, plan.count_month] if self.count_month != plan.count_month
		result << plan.created_at
		return result
	end

end
