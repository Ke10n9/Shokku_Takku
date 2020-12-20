module MenusHelper

  def menu_image(menu)
    if menu.picture.url
      image_tag(menu.picture.url, id: "form-menu-img")
    else
      image_tag("no_image.png", id: "form-menu-img")
    end
  end
end
