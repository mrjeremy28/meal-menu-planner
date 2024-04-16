
class Rational

  def to_simplified_s
    if self < 1
      to_s
    else
      truncated = self.truncate
      truncated == self ? truncated.to_s : "#{truncated} #{self - truncated}"
    end
  end

end
