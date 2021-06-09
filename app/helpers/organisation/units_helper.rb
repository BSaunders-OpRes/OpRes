module Organisation::UnitsHelper
  def journey_unit_decoration(unit)
    if unit.incomplete?
      { status_text: 'Incomplete', link_text: 'Get Started', list_class: 'white-selection', text_class: 'text-danger' }
    elsif unit.inprogress?
      { status_text: 'In Progress', link_text: 'Resume', list_class: 'white-selection', text_class: 'text-dark-yellow' }
    elsif unit.completed?
      { status_text: 'Completed', link_text: 'Edit', list_class: 'black-selection', text_class: 'text-success' }
    end
  end
end
