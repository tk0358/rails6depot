module SetCounter

  private

  def set_counter
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
    @counter = session[:counter]
  end
end