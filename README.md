# EntainCodeChallenge

# Structure and Architecture
- I used an MVVM pattern ensuring all logic is separated from the Views.
- A Client is used to fetch the data, this conforms to a Protocol which could be used for an offline JSON Client for example
Data models are decoded using the Decodable protocol with CodingKeys
- `RaceType` is a custom enum decoded by the `categoryId`.

# AppConstants
- This file contains several values that are used through the project.
- These can be altered for testing, for example change the ` automaticRefreshInSeconds` to a lower number so the view is refreshed quickly.

# Design and UI
- Filters are Buttons at the top of the List, if more types are required we would just update the enum
- The Header view shows the remaining time before a refresh with an animation 5 Races are shown in a list
The time of the last update is noted in the footer of the list

# Filtering
- I took inspiration from the Neds app and website when it came to the filter buttons and they’re functionality.
- If a User taps a filter, it will be deselected.
- If there is only 1 filter selected and it is tapped, all 3 will be reselected.
