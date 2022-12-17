class Public::HomesController < ApplicationController
  def top
    @knowledges = Knowledge.all
    if @knowledges.count >= 10
      @knowledges = @knowledges.sort_by { |knowledge| -knowledge.avg_rate }.slice(0..9)
    else
      @knowledges = @knowledges.sort_by { |knowledge| -knowledge.avg_rate }
    end
  end
end
