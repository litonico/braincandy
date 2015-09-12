type Vec = (Double, Double)

distance :: Vec -> Double
distance (x, y) = sqrt (x**2 + y**2)

is_inside :: Vec -> Bool
is_inside (x, y) = (x*x + y*y) < 1

main :: IO ()
main = do
