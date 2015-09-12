def nCr n, r
  (1..n).to_a.combination(r).to_a.length # TODO(Lito): a REAL bincoef
end

def pascal height, triangle=[]
  if height == 0
    [[1]]
  else
    this_generation = (0..height).map do |coef|
      nCr height, coef
    end
    triangle << this_generation
    triangle.concat pascal(height-1)
  end
end
