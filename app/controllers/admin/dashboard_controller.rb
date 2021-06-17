class Admin::DashboardController < Admin::BaseController
  def index
    @users_by_month = User.where('role != ?', User.roles[:application_admin])
                         .where(created_at: ((Time.now - 4.months).at_beginning_of_month)..(Time.now.at_end_of_month))
                         .group("date_trunc('month', created_at)").count

    colors = %w[#6BEAB3 #367C5C #CDFAF1 #CDFAF1]

    @users_total = @users_by_month.values.sum
    @users_percentage_by_month = []
    @users_by_month.each_with_index do |(k, v), index|
      @users_percentage_by_month << {
        name: k.strftime('%B'),
        y: ((v / @users_total.to_f) * 100).to_i,
        color: colors[index]
      }
    end

    @organizations = Units::Organisational.includes(:users)
  end

  def myAccount
  end
end
