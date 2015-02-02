fizzBuzz = (num) ->
	console.log(num, "FizzBuzz") if (num % 15 == 0);
	console.log(num, "Buzz") if (num % 5 == 0);
	console.log(num, "Fizz") if (num % 3 == 0);
	console.log(num) if (num % 15 != 0 && num % 5 != 0 && num % 3 != 0);

	return fizzBuzz(num + 1) if (num < 100);

fizzBuzz(1); 