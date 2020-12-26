module MenusHelper

  def menu_image(menu, id)
    if menu.picture.url
      image_tag(menu.picture.url, id: id)
    else
      image_tag("no_image.png", id: id)
    end
  end
end
