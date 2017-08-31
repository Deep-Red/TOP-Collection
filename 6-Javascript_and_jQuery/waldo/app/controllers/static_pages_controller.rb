class StaticPagesController < ApplicationController
  def home
    @@counter = 0
    @@start = Time.now
  end

  def checkItem
    answer = checkAnswer(params[:x], params[:y], params[:item]);
    if (@@counter == 3)
      @@official_score = score
      flash[:success] = "Nice! You found all three in #{@@official_score} seconds"
      render js: "location.reload()"
    else
      render json: answer
    end
  end

  def enter_score
    if highscore?
      @newscore = Score.new
      @newscore.score = @@official_score
      respond_modal_with @newscore
    end
  end

  def record_score(score)
    render
    s = Score.new
    s.score = score
    s.name = "A"
    s.save
  end

  private

  def score
    ( Time.now - @@start ).floor
  end

  def highscore?
    low_high = Score.order('score').first
    low_high.score > @@official_score ? true : false
  end

  def display_scores
    @scores = Score.all.order('score asc')
  end

  def checkAnswer (x, y, name)
    c = Item.where(name: name.to_s)[0]
    if (x.to_i.between?(c.xpos - 15, c.xpos + 15) && y.to_i.between?(c.ypos - 15, c.ypos + 15))
      @@counter += 1
      return {name: c.name, xpos: c.xpos, ypos: c.ypos}
    else
      return false
    end
  end
end
