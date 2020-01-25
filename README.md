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

Scroll down on weather screen performs two function add localisation
to database and refresh weather data. added city can be deleted on text field
page by dissmisable by sliding to any direction.


