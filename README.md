# sunshine

Simple weather application using Bloc architecture.

## Getting Started

Project is based on google Flutter framework.


Project structure:
- backend (Folder for business logic)
- config  (App configuration)
- data    (Sqflite database helper)
- models  (models for parsing api json)
- repository (open weathermap comunication methods)
- screen    (application screens)
- widgets   (single costume widgets build due tue )
- main.dart (entry point to application)
- simple_bloc_delegate.dart (bloc architecture delegate for debug purpose)

Application has dynamic theming based on weather condition.
## View on welcome page animation
![Image 1](assets/docimg/Screenshot_2020-01-25-20-31-08-037_com.sunshine.sunshine.jpg)

## View on weather view with dynamic theme
![Image 1](assets/docimg/Screenshot_2020-01-25-19-59-19-833_com.sunshine.sunshine.jpg)

## Dynamic Theming example 1
![Image 5](assets/docimg/Screenshot_2020-01-25-20-00-50-140_com.sunshine.sunshine.jpg)

## Dynamic Theming example 2
![Image 6](assets/docimg/Screenshot_2020-01-25-20-01-16-335_com.sunshine.sunshine.jpg)

## Dynamic Theming example 3
![Image 7](assets/docimg/Screenshot_2020-01-25-20-36-56-305_com.sunshine.sunshine.jpg)

## View on City list and search form during city deleting
![Image 2](assets/docimg/Screenshot_2020-01-25-19-59-40-204_com.sunshine.sunshine.jpg)

## Filling the form
![Image 4](assets/docimg/Screenshot_2020-01-25-20-00-32-206_com.sunshine.sunshine.jpg)

## Everyday notification depends on geo localisation. Clicking on notification opens app. After getting localisation shows weather condition
![Image 7](assets/docimg/Screenshot_2020-01-25-20-36-14-206_com.sunshine.sunshine.jpg)

## Getting from user permission to reach hardware localisation
![Image 7](assets/docimg/Screenshot_2020-01-25-20-36-46-366_com.google.android.packageinstaller.jpg)


Scroll down on weather screen performs two functionality, adding localisation
to database and refreshing weather data. Added city can be deleted on CitySelection.
Cities list wrapped my ListView builder with card children. Tapping on city card performs weather checking operation.


