module ImageHelper
  def show_image_related_to(object)
    image_tag object.image_url, class: 'img-responsive img-thumbnail' if object.image.present?
  end

  def show_circle_image_related_to(object)
    image_tag object.image_url, class: 'img-responsive img-thumbnail img-circle img-stage-preview' if object.image.present?
  end
end
