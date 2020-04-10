class StaticsController < ApplicationController

  def about
    @nav = :about
  end

  def faq
    @nav = :faq
  end


end
