Number.prototype.greatherThan =
  function(n){
    return this > n
  };
(2).greatherThan(1) &&
(1).greatherThan(2)

Number.prototype.isOne = 
  function(n){
    return this === 1
  };
(1).isOne()

Number.prototype.isTwo =
  function(n){
    return +this === 2
  };
(2).isTwo()

function nextNumber(number) {
  return number + 1
}
nextNumber(2) + 1 === nextNumber(3)

"1" + 1 == 2

1 + "1" == 2

! isNaN(Number("") / false)

2 - "1" == 1

isNaN(Infinity)

2 - "1" == "1"

Number("1") / +false == Infinity


