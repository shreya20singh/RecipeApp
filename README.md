# Recipe App

Recipe App is a mobile application that allows users to explore and discover a wide range of recipes.
### APIs used:
- https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
- https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID
## Features

### Recipe Listing
- Browse a diverse selection of recipes.
- Each recipe is displayed with its name and a mouthwatering image.

### Recipe Details
- View detailed information about a selected recipe, including the meal name and instructions.
- Explore the ingredients used in the recipe.

### Video Integration
- Watch video tutorials for specific recipes via integrated YouTube videos.

### Categorization and Tags
- Recipes are categorized and tagged, making it easy to find dishes based on your preferences.

### Source Information
- Access the source of the recipe for additional details.

### User Interaction
- Pull to refresh the recipe listings for the latest and most up-to-date results.
- Easily refresh the content by tapping a dedicated "Refresh" button.

### Progressive Loading
- Displays a loading indicator while fetching recipe data.
- Provides a seamless user experience by indicating that content is being loaded.

### Error Handling
- Gracefully handles potential errors and displays user-friendly messages in case of issues.
- Ensure a smooth user experience by addressing problems that may arise during use.
  
### Unit Tests
- Added unit tests for both services with Mock data. Given more time, I would add UI Test cases as well.


## Screenshots
<img src="https://github.com/shreya20singh/RecipeApp/blob/main/Screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202023-10-25%20at%2011.55.34.png" width="250" height="400"> <img src="https://github.com/shreya20singh/RecipeApp/blob/main/Screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202023-10-25%20at%2011.55.47.png" width="250" height="400">
<img src="https://github.com/shreya20singh/RecipeApp/blob/main/Screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202023-10-25%20at%2011.55.08.png" width="250" height="400"> <img src="https://github.com/shreya20singh/RecipeApp/blob/main/Screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202023-10-25%20at%2011.55.17.png " width="250" height="400">
<img src="https://github.com/shreya20singh/RecipeApp/blob/main/Screenshots/Screenshot%202023-10-25%20at%2012.54.34.png" width="500" height="200">


## Built With

- [Swift](https://developer.apple.com/swift/)
- [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- [Kingfisher](https://github.com/onevcat/Kingfisher) - For image loading and caching
- [AVKit](https://developer.apple.com/av-foundation/)
- [YouTube Data API](https://developers.google.com/youtube/registering_an_application) - For video integration

