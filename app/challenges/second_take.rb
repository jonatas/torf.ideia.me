nil.nil?.nil?

["#{nil}"].all? &:nil?

5 / 2 == 2.5

a ||= true

a ||= false

a == true

"rumble".split("r")[0].empty?

"rumble".split("u")[0].empty?

"rumble".split("x")[0].empty?

"rumble".split("")[1,2].reverse * 2 == "mumu"

-> { begin true ensure false end }.() == false

sequence = (1..10).to_a
even, odd = sequence.inject([[],[]]) do |array,e|
  array[(e % 2)].push(e)
  array
end
even[-1] == 10

odd.first == 1

even.last + odd.reverse.first == 19

sequence.select {|e| e % 2 == 0} == [2,4]

(even + odd).sort != sequence

def a ; end == :a

a.nil? == true