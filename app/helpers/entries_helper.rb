module EntriesHelper

  def delete_entry
    "<span class='delete_x unevented'><a href='DELETETHING.SETTOSOMETHINGUSEFUL'><img class='on' src='/images/delete_on.png' style='display:none'><img class='off' src='/images/delete_off.png'/></a></span>"
  end

  def delete_entrymatch
    delete_entry
  end
  
end
