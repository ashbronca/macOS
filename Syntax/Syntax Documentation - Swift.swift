// Syntax Documentation - Swift

Simple Types

	
	Variables

		// You can change the value of variables freely
			var str = "Hello, Playground"
		// This creates a variable named str. Because this is a variable, we can change the value
			str = "Goodbye"

	Strings and Integers

		// The below line of code, holds an Int value (Integer) which is a whole number.
			var age = 38
		// You can write larger numbers with underscores and still class it is an Int value type
			var population = 8_000_000

	Multi-line Strings

		// Standard strings use double quotes, but you cannot include line breaks. If you want multi-line strings, you need to use the following three double quote syntax
			var str1 = """
			This goes
			over multiple
			lines
			"""

		// If you only want the code to be formatted neatly, but not have line breaks, you would use the following syntax
			var str1 = """
			This goes \
			over multiple \
			lines
			"""

	Doubles Booleans

		// Two other basic types of data in swift are Doubles and Booleans. Double is short for "double-precision floating-point number", which means it holds fractional values such as 38.1, or 3.133345346.
		// You can write a fractional number, and swift will use type inference to assign a data type of Double.
			var pi = 3.141

		// Swift will automatically assign a Bool value to something if it has a true or false value.
			var awesome = true

	string Interpolation

		// String Interpolation allows you to place variables inside your strings to make them more useful. You can place any type of variable inside your string - all you have to do is write a backslash, followed by your variable in parentheses.
			var score = 85
			var str = "Your score was \(score)"

		// You can do this as many times as you need, making strings out of strings if you want:
			var results = "The test results are here: \(str)"

	Constants

		// We use the let keyword to symbolize an immutable value - this is called a constant. Unlike the mutable var keyword for variable, let cannot be changed once created.
			let taylor = "swift"

		// If you try to change this in Xcode, it will refuse to run. It is a form of safety: when you use constants, you can no longer change something by accident.

	type Annotations

		// Swift assigns each variable and constant a type based on what value it's given when it is created. The following holds a string
			let str = "Hello, Playground"

		// That will make str a string, so you cannot try to assign it an integer or a boolean later on. This is called type inference: swift is able to infer the type of something based on how you created it. 
		// If you want to be explicit about the type of your data rather than relying on swift's type inference, like this:
			let album: String = "Reputation"
			let year: Int = 1989
			let height: Double = 1.78
			let taylorRocks: Bool = true

	Simple Types: Summary /*

		1. You make variables using var and constants using let. It's preferred to use the constants as often as possible.
		2. Strings start and end with double quotes, but if you want them to run across multiple lines, you should use three sets of double quotes.
		3. Integers hold whole numbers, duobles hold fractional numbers, and booleans hold true or false.
		4. String interpolation allows you to create strings from other variables and constants, placing their values inside your string.
		5. Swift uses type inference to assign each variable or constant a type, but you can provide explicit types if you want. */


Complex Tupes


	Arrays

		// Arrays are collections of values that are stored as a single value. In code, we write this. The last line makes the array: it starts and ends with brackets, with each item in the array seperated by a comma.
			let john = "John Lennon"
			let paul = "Paul McCartney"
			let george = "George Harrison"
			let ringo = "Ringo Starr"
			let beatles = [john, paul, george, ringo]

		// You can read values from an array by writing a number inside brackets. Array positions count from 0, so if you want to read "Paul McCartney", you would write this:
			beatles[1]

		// NOTE: If you're using type annotations, arrays are written in brackets:
			[String], [Int], [Double], and [Bool]

	Sets

		// Sets are collections of values just like arrays, except they have two differences 
		/*

		1. Items aren't stored in any order, they are stored in what is effectively a random order. 
		2. No item can appear twice in a set; all items must be unique */

		// You can create sets directly from arrays, like this:
			let colors = Set(["red", "green", "blue"])

		// Because they are unordered, you cannot read values from a set using numerical positions like you can with arrays.

	Tuples

		// Tuples allow you to store several values together in a single value. That might sound like arrays, but tuples are different:
		/*
		1. You can't add or remove items from a tuple; they are fixed in size
		2. You can't change the type of items in a tuple; they always have the same types they were created with.
		3. You can access items in a tuple using numerical positions of by naming them, but Swift won't let you read numbers or names that don't exist.
		*/

		// Tupes are created by placing multiple items into parentheses, like this: 
			var name = (first: "Taylor", last: "Swift")

		// You then acess items using numerical positions starting from 0:
			name.0

		// or you can access items using their names:
			name.first

		// You can change the values inside a tuple after you create it, but not the types of values.

	Arrays vs Sets vs Tuples

		// If you need a specific, fixed collection of related values where each item has a precise position or name, you should use a tuple:
			let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")

		// If you need a collection of values that must be unique or you need to be able to check whether a specific item is in there extremely quickly, you should use a set:
			let set = Set(["aardvark", "astronaut", "azalea"])

		// If you need a collection of values that can contain duplicates, or the order of your items matters, you should use an array. Arrays are by far the most common of the three types.
			let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]

	Dictionaries

		// Dictionaries are collections of values jsut like arrays, but rather than storing things with an integer position you can access them using anything you want.
		// The most common way of storing dictionary data is using strings, For example, we could create a dictionary that stores the height of singers using their name:
			let heights = [
				"Taylor Swift": 1.78,
				"Ed Sheeran": 1.73
			]

		// Read the key data
			heights["Taylor Swift"]

		// NOTE: When using type annotations, dictionaries are written in brackets with a colon between your identifier and value types. For example:
			[String: Duoble] and [String: String]

		// We can add a default value using the following syntax, in the event that we call a key that does not exist
			heights["Camila", default: "Unknown"]

	Creating Empty Collections

		// Arrays, sets and dictionaries are called collections, because they collect values together in one place.
		// If you want to create an empty collection just write its type followed by opening and closing parentheses. For example, we can create an empty dictionary with strings for keys and values like this:
			var teams = [String: String]()

		// We can then add entries later on, like this:
			teams["Paul"] = "Red"

		// Similarly, you can create an empty array to store integers like this:
			var results = [Int]()

		// The exception is creating an empty set, which is done differently:
			var words = Set<String>()
			var numbers = Set<Int>()

		// This is because Swift has special syntax only for dictionaries and arrays; other types must use angle bracket syntax like sets.
		// If you wanted, you could create arrays and dictionaries with similar syntax:
			var scores = Dictionary<String, Int>()
			var results = Array<Int>()

	Enumerations

		// Enumerations - usually called just enums - are a way of defining groups of related values in a wau that makes them easier to use.
		// For example, if you wanted to write some code to represent the success or failure of some work you were doing, you could represent that as strings:
			let result = "failure"

		// But what happens if someone accidentally uses different naming?
			let result2 = "failed"
			let result3 = "fail"

		// All those three are different strings, so they mean different things. With enums, we can define a Result type that can be either success or failure, like this:
			enum Result {
				case success
				case failure
			}

		// And now when we use it we must choose on of those two values. This stops you from accidentally using different strings each time.
			let result4 = Result.failure

		// As well as storing a simple value, enums can also store associated values attached to each case. This lets you attach additional information to your enums so they can represent more nuanced data.
		// For example, we might define an enum that stores various kinds of activities:
			enum Activity {
				case bored
				case running
				case talking
				case singing
			}

		// That lets us say that someone is talking, byt we don't know what they are talking about, or we can know that someone is running, but we don't know where the are running to. Enum associated values let us add those additional details:
			enum Activity {
				case bored
				case running(description: String)
				case talking(topic: String)
				case singing(volume: Int)
			}

		// Now we can be more precise - we can say that someone is talking about football:
			let talking = Activity.talking(topic: "football")

		// Sometimes you need to be able to assign values to enums so they have meaning. This lets you create them dynamically, and also use them in different ways. 
		// For example, you might create a planet enum that stores integer values for each of its cases:
			enum Planet: Int {
				case mercury
				case venus
				case earth
				case mars
			}

		// Swift will automatically assign each of those a number starting from 0, and you ca use that number to create an instance of the appropriate enum case. For example, earth will be given the number 2, so you can write this:
			let earth = Planet(rawValue: 2)

		// If you want, you can assign one or more cases a specific value, and Swift will generate the reset. It's not very natural for us to think of Earth as the second planet, so you could write this:
			enum Planet: Int {
				case mercury = 1
				case venus
				case earth
				case mars
			}

		// Now Swift will assign 1 to mercury and count upwards from there, meaning that earth is now the third planet.

		Complex Types: Summary /*

		1. Arrays, sets, tuples, and dictionarieslet you store a group of items under a single value. They each do this in different ways, so which you use depends on the behaviour you want.
		2. Arrays store items in the order you add them, and you access them using numerical positions. 
		3. Sets store items without any order, so you can't access them using numerical positions.
		4. Tuples are fixed in size, and you can attach names to each of their items. You can read items using numerical positions or using your names.
		5. Dictionaries sotre items according to a key, and you can read items using those keys.
		6. Enums are a way of grouping related values so you can use them without spelling mistakes.
		7. You can attach values to enums so the can be created from integers or strings, or you can add assiciated values to store additional information about each case.






