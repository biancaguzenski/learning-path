class GeometryExpression  
  Epsilon = 0.00001
end

class GeometryValue 

  private
 
  def real_close(r1,r2) 
      (r1 - r2).abs < GeometryExpression::Epsilon
  end
  def real_close_point(x1,y1,x2,y2) 
      real_close(x1,x2) && real_close(y1,y2)
  end
  
  def two_points_to_line(x1,y1,x2,y2) 
      if real_close(x1,x2)
        VerticalLine.new x1
      else
        m = (y2 - y1).to_f / (x2 - x1)
        b = y1 - m * x1
        Line.new(m,b)
      end
  end

  public
  
  def intersectNoPoints np
    np
  end

  def intersectLineSegment seg
    line_result = intersect(two_points_to_line(seg.x1,seg.y1,seg.x2,seg.y2))
    line_result.intersectWithSegmentAsLineResult seg
  end
end

class NoPoints < GeometryValue
  
  def eval_prog env 
    self # all values evaluate to self
  end
  def preprocess_prog
    self # no pre-processing to do here
  end
  def shift(dx,dy)
    self # shifting no-points is no-points
  end
  def intersect other
    other.intersectNoPoints self # will be NoPoints but follow double-dispatch
  end
  def intersectPoint p
    self # intersection with point and no-points is no-points
  end
  def intersectLine line
    self # intersection with line and no-points is no-points
  end
  def intersectVerticalLine vline
    self # intersection with line and no-points is no-points
  end
  
  def intersectWithSegmentAsLineResult seg
    self
  end
end


class Point < GeometryValue
  
  attr_reader :x, :y
  def initialize(x,y)
    @x = x
    @y = y
  end

  def eval_prog env 
    self # all values evaluate to self
  end
  def preprocess_prog
    self # no pre-processing to do here
  end
  def shift(dx,dy)
    Point.new(@x+dx, @y+dy)
  end
  def intersect other
    other.intersectPoint self
  end
  def intersectPoint p
    if real_close_point(@x,@y,p.x,p.y)
      self
    else
      NoPoints.new
    end
  end
  def intersectLine line
    if real_close(@y, line.m * @x + line.b)
      self
    else
      NoPoints.new
    end
  end
  def intersectVerticalLine vline
    if real_close(@x1, vline.x)
      self
    else
      NoPoints.new
    end
  end
  
  def intersectWithSegmentAsLineResult seg
    if inbetween(@x, seg.x1, seg.x2) and inbetween(@y, seg.y1, seg.y2)
      Point(@x, @y) # can prob return self here?
    else
      NoPoints.new
    end
  end

  def inbetween v, end1, end2
    (end1 - GeometryExpression::Epsilon <= v and v <= end2 + GeometryExpression::Epsilon) or (end2 - GeometryExpression::Epsilon <= v and v <= end1 + GeometryExpression::Epsilon)
  end

end

class Line < GeometryValue
  
  attr_reader :m, :b 
  def initialize(m,b)
    @m = m
    @b = b
  end

  def eval_prog env 
    self # all values evaluate to self
  end
  def preprocess_prog
    self # no pre-processing to do here
  end
  def shift(dx,dy)
    Line.new(@m, @b+dy-@m*dx)
  end
  def intersect other
    other.intersectLine self # will be NoPoints but follow double-dispatch
  end

  def intersectPoint p
    p.intersectLine(self) # Already defined in Point
  end
  def intersectLine line
    if real_close(@m, line.m)
      if real_close(@b, line.b)
        self
      else
        NoPoints.new
      end
    else
      x = (line.b - @b) / (@m - line.m)
      y = @m * x + @b
      Point.new(x,y)
    end
  end
  def intersectVerticalLine vline
    Point.new(vline.x, @m * vline.x + @b)
  end
  def intersectWithSegmentAsLineResult seg
    return seg
  end
end

class VerticalLine < GeometryValue
  
  attr_reader :x
  def initialize x
    @x = x
  end

  def eval_prog env 
    self # all values evaluate to self
  end
  def preprocess_prog
    self # no pre-processing to do here
  end
  def shift(dx,dy)
    VerticalLine.new(@x+dx)
  end
  def intersect other
    other.intersectVerticalLine self # will be NoPoints but follow double-dispatch
  end
  def intersectPoint p
    p.intersectVerticalLine(self) # Already defined in Point
  end
  def intersectLine line
    line.intersectVerticalLine(self)
  end
  def intersectVerticalLine vline
    if real_close(@x, vline.x)
      self
    else
      NoPoints.new
    end
  end
  def intersectWithSegmentAsLineResult seg
    return seg
  end
end

class LineSegment < GeometryValue
  
  attr_reader :x1, :y1, :x2, :y2
  def initialize (x1,y1,x2,y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def eval_prog env 
    self # all values evaluate to self
  end
  def preprocess_prog
    if real_close_point(@x1,@y1,@x2,@y2)
      Point.new(@x1,@y1)
    elsif real_close(@x1, @x2) and @y2 < @y1 or @x2 < @x1
      LineSegment.new(@x2, @y2, @x1, @y1)
    else
      self
    end
  end
  def shift(dx,dy)
    LineSegment.new(@x1+dx, @y1+dy, @x2+dx, @y2+dy)
  end
  def intersect other
    other.intersectLineSegment self # will be NoPoints but follow double-dispatch
  end
  def intersectWithSegmentAsLineResult seg
    seg2 = self
    if real_close(seg.x1, seg.x2)
      b = seg
      a = seg2
      if seg.y1 < seg2.y1
        a = seg
        b = seg2
      end
      if real_close(a.y2, b.y1)
        Point(a.x2, a.y2) # Just touching
      elsif a.y2 < b.y1
        NoPoints.new # disjoint
      elsif a.y2 > b.y2
        LineSegment.new(b.x1, b.y1, b.x2, b.y2) # b inside a
      else
        LineSegment.new(b.x1, b.y1, a.x2, a.y2) # overlapping
      end
    else
      a = seg2
      b = seg
      if seg.x1 < seg2.x1
        a = seg
        b = seg2
      end
      if real_close(a.x2, b.x1)
        Point.new(a.x2, a.y2) # Just touching
      elsif a.x2 < b.x1
        NoPoints.new # disjoint
      elsif a.x2 > b.x2
        LineSegment.new(b.x1, b.y1, b.x2, b.y2) # b inside a
      else
        LineSegment.new(b.x1, b.y1, a.x2, a.y2) # overlapping
      end
    end
  end
end

class Intersect < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize(e1,e2)
    @e1 = e1
    @e2 = e2
  end
  def preprocess_prog
    Intersect.new(@e1.preprocess_prog, @e2.preprocess_prog)
  end
  def eval_prog env
    e1_value = @e1.eval_prog(env)
    e2_value = @e2.eval_prog(env)
    e1_value.intersect(e2_value)
  end
end

class Let < GeometryExpression
  
  def initialize(s,e1,e2)
    @s = s
    @e1 = e1
    @e2 = e2
  end
  def preprocess_prog
    Let.new(@s, @e1.preprocess_prog, @e2.preprocess_prog)
  end
  def eval_prog env
    eval_value = @e1.eval_prog(env)
    new_env = [[@s, eval_value]] + env
    @e2.eval_prog(new_env)
  end
end

class Var < GeometryExpression
  
  def initialize s
    @s = s
  end
  def preprocess_prog
    self # no pre-processing to do here
  end
  def eval_prog env # remember: do not change this method
    pr = env.assoc @s
    raise "undefined variable" if pr.nil?
    pr[1]
  end
end

class Shift < GeometryExpression
  
  def initialize(dx,dy,e)
    @dx = dx
    @dy = dy
    @e = e
  end
  def preprocess_prog
    Shift.new(@dx, @dy, @e.preprocess_prog)
  end
  def eval_prog env
    eval_value = @e.eval_prog(env)
    eval_value.shift(@dx,@dy)
  end
end