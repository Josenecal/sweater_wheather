class Api::V1::BackgroundsController << ApplicationController

  def show
    BackgroundsFacade.get_backgrounds(location)
  end

end
