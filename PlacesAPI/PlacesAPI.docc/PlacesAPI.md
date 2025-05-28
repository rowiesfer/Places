# ``PlacesAPI``

Very basic "horizontal" module that is in charge of making HTTP requests to the provided data source in the assignment.

### Architecture
Due to the simplicity of the data source provided, this module is probably overkill, but I wanted to exemplify how I envision modularity in larger apps.
This module in particular is a horizontal module that could be used by multiple vertical modules — as in the case of this app: PlaceList.
In a larger application, this module could also encapsulate more logic related to HTTP communication with the server, such as authentication. It could even be used by another horizontal module that provides persistent storage for the retrieved data.
