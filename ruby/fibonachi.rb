def fibonachi(n)
  i = 2
  arr = [0, 1]
  return [0] if n == 1
  while i < n
    arr << arr[i-1] + arr[i-2]
    i += 1
  end
  arr
end

def fibonachi_rec(n)
  return [0, 1] if n == 2
  arr = fibonachi_rec(n-1)
  return arr << arr[-1] + arr[-2]
end

p fibonachi(18000)
p fibonachi_rec(18000) # faster :)
