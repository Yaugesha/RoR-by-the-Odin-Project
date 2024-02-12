class Calculator

  def add(*args)
    args.sum
  end

  def multiply(*args)
    args.reduce { |res, number| res *= number }
  end

  def devide(devident, *args)
    args.reduce(devident) { |res, number| res /= number }
  end
end
