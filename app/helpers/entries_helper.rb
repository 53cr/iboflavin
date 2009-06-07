module EntriesHelper

  def delete_entry(id)
    images = "<img class='on' src='/images/delete_on.png' style='display:none'><img class='off' src='/images/delete_off.png'/>"
    link = link_to images, entry_url(id)
    "<span class='delete_x unevented'>#{link}</span>"
  end

  def delete_entrymatch(id)
    images = "<img class='on' src='/images/delete_on.png' style='display:none'><img class='off' src='/images/delete_off.png'/>"
    link = link_to images, entry_match_url(id)
    "<span class='delete_x unevented'>#{link}</span>"
  end
  
end
