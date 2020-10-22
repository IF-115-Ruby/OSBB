class HomeController < ApplicationController
  def index; end

  def about; end

  def custom_error; end

  def random_error
    Raven.capture do
      raise Exception.descendants.sample
    end
  end
end
