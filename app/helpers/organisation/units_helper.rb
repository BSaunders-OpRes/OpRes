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

  def transform_inprogress_text(status)
    return status unless status == 'inprogress'
    'In Progress'
  end
end
