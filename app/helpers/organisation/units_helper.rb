module Organisation::UnitsHelper
  def btn_text(status)
    case status
    when 'incomplete'
      'Get Started'
    when 'inprogress'
      'Resume'
    when 'completed'
      'Edit'
    end
  end
end
