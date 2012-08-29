class PagesController < ApplicationController
  def home
    @title = "Sample App Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end
  
  def news
    @title = "News"
  end

end
