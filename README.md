# Would You Rather

With 1,900,000,000 people overweight, there are more diet related deaths than deaths by smoking!

The biggest barriers to eating healthy is the convenience, cost, and time/difficulty of cooking.

To address this issue, we decided to create an app that finds you dishes from a prefered cuisine for breakfast, lunch, and dinner, and then provides you with multiple options. You get a side-by-side comparison of various dishes, with information about their nutrition (and a nutrition score), the time it takes to cook, and the cost of the ingredients (optimizing for lowest available cost). After selecting the dish you get linked to top rated recipes that you can pull up directly in the app, and you also have the option to purchase the ingredients directly by linking the necessary ingredients directly to instacart's api and allowing you to make the purchase with a push of a button.

## Technologies

We used Flutter for our front-end UX, CockroachDB to store preferences and favourites data, the Spoonacular API for dish information, and Flask to talk to Spoonacular and CockroachDB, all of which is hosted on Azure with active directory for authentication.

## Business Info

For revenue model and competitor information, please consult the Judging Presentation above.


## Preview

![Screen 1](https://user-images.githubusercontent.com/32528837/157807032-e0db0234-bb38-4a23-974a-a9efa5ee54f7.jpg)

![Screen 2](https://user-images.githubusercontent.com/32528837/157810254-0db7076f-3fbb-483c-8d2a-4ac2a26eff17.png)

![Screen 3](https://user-images.githubusercontent.com/32528837/157807064-30a927dd-3570-484c-80fb-d13db3fea376.jpg)
