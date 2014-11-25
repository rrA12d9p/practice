# Never a single answer!!

###Prompt:

####The Manager:
- You are the manager of TeeSwag, a small online t-shirt store where customers can't see what they ordered until it is delivered to their door. 
- You decide to use an application that lets you manage your inventory and daily sales.
- You can record sales by tracking your customers' purchases.

####The Customer:
- As the customer, you can visit the store and make purchases!


### The deets

##### Objects: Attributes && methods
- Store class:
 - Attributes:
 	- A store should start with no sales (`@daily_sales = 0`)
 	- A store should start with a full inventory (`@inventory = 60`)
 - Actions:	
 	- The manager can add t-shirts to the store's inventory when the stock goes below 30

- Customer class:
  - Attributes:
		- A customer should have a cart
		- A customer should have a balance
 - Actions:	
 	- A customer can check the store's inventory
	- A customer can add items to their cart after checking the store's inventory
	- A customer can checkout
		- Checking out should update their balance and empty out their cart
	- When the customer's balance is updated it should update the store's daily sales

- T-shirt class:
  - Attributes:
		- A t-shirt should have a price
 - Actions:	
 	- The manager can put a t-shirt on sale


##Steps:
- Today is about learning from each other and thinking of different ways to do things
- Breakout into groups of 3 and pseudo-code the steps to make all the objects' attributes and actions 
- Think about the customer, the tshirts and the store as different entities
- Once you have defined your classes, how will you make them work together?
- If you're feeling good, you can start writing code for the exercise
