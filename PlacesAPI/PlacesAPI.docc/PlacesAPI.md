# ``PlacesAPI``

Very basic "horizontal" module that is in charge of making HTTP requests to the provided data source in the assignment.

### Discussion
Due to the simplicity of the data source provided this module is probably an overkill but I wanted to exemplify how I envision modularity in bigger apps.
This module in particular is a "horizontal" module that could be used for multiple other "vertical" modules. Like in the case of this app: PlaceList.
In a larger application this module could also encapsulate more logic related to HTTP communication with the server, like authentication. Or even be used by another horizontal module that provides persistent storage of the data retrieved.
