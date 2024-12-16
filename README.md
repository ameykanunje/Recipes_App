# RecipesApp

# Steps to Run the App
1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Ensure you have the latest version of Xcode installed (Xcode 14 or later recommended).
4. Select your desired simulator or connected device.
5. Click the 'Run' button or press `Cmd+R` to build and run the app.

# Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I prioritized the following areas:

- **API Integration:** I focused on creating a robust and reusable `APIManager` class that can handle various endpoints and decode different model types. This approach ensures scalability and maintainability as the app grows.
- **UI Development and App Lifecycle:** I implemented the user interface using SwiftUI, focusing on creating an intuitive and responsive design. To enhance performance, I incorporated an image caching system that stores images locally after the initial load. This approach significantly improves load times for previously viewed recipes and reduces data consumption.
- **Testing:** I created comprehensive tests for the `APIManager` to ensure its reliability and catch potential issues early in the development process.

I chose these areas because they form the foundation of an efficient and user-friendly iOS app. A solid API integration ensures reliable data flow, while leveraging SwiftUI for the UI and implementing smart image handling results in a responsive and performant app. Thorough testing helps maintain code quality and prevents regressions as the app evolves.

# Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent approximately 9 hours on this project. The time was allocated roughly as follows:

- 3 hours on initial project setup and API integration
- 1 hours on UI design and implementation
- 3 hours on writing and refining tests
- 1 hour on documentation and code cleanup
- 1 hour on reviewing and optimizing the overall architecture

# Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

- **Generic API Manager:** I implemented a generic `APIManager` that can handle different endpoint types and model types. While this adds some complexity, it provides great flexibility and reusability for future development.
- **Direct API Dependency:** The current implementation is directly dependent on the API. While this allows for real-time data, in a production environment, I would implement caching and offline support to improve the user experience and reduce API dependency.
- **URLSession.shared vs. Dependency Injection:** I chose to use `URLSession.shared` for this initial implementation. This decision was made to prioritize getting a working prototype up and running quickly. In a future iteration, I would refactor this to use dependency injection, allowing for better testability and flexibility.
- **Computed Properties vs. Stored Properties:** I decided to use computed properties for URL conversions in the `Recipe` model. This saves memory as we don't store additional URL objects, but it does mean we perform the conversion each time we access these properties.


# Weakest Part of the Project: What do you think is the weakest part of your project?
The area with the most room for improvement is the testing strategy. The current tests based on default sessions. In a future iteration, I would implement a mock `URLSession` to allow for more controlled, repeatable tests that don't depend on external factors.

Additionally, while the current error handling in the `APIManager` catches and throws errors, a more robust implementation would include more specific error types and potentially include recovery suggestions for each error type.

# External Code and Dependencies: Did you use any external code, libraries, or dependencies?
This project doesn't use any external libraries or dependencies beyond the standard iOS SDK. All code was written from scratch to meet the specific needs of this project.

# Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
During development, I encountered a few interesting challenges and made some strategic decisions:

- **API Dependency:** The current implementation is closely tied to the API. This was a conscious decision to get a working prototype quickly. In a production app, I would implement local caching and offline support to reduce API dependency and improve the user experience.
- **Error Handling:** The current error handling is functional but basic. In a production environment, I would implement more granular error types and user-friendly error messages.

These decisions were made with the goal of delivering a functional prototype within the given timeframe. Each represents an opportunity for future improvement and optimization as the project evolves.
