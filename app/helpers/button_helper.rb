module ButtonHelper
  def toggle_button_for(object)
    value = object.present? ? 'none' : 'inline-block'
    "display:#{value}"
  end
end
