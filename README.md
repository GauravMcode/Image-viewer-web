# Pixabay Images App

Flutter Application that fetches images from Pixabay. 

## Packages Used:
-  *infinite_scroll_pagination* is used for pagination and after fetching 10 images the api is called again
-  *get* for getx state management
-  *http* for api calls
-  *loading_animation_widget* for loader animations
-  *logger* for logging purpose
-  *flutter_dotenv* to secure api key of pixabay

## Architecture:

The Project has been structured into Model View Controller (MVC) and Services folder
Along with images, The cards also display user name and profile photo, tags, likes and views