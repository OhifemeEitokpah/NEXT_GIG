# NEXT_GIG

## Project Overview
NEXT_GIG is a web application that provides a platform for users to manage their gigs and events. The application includes user authentication using Devise, allowing users to sign up, log in, and manage their profiles.

## File Structure
The project has the following structure:

```
NEXT_GIG
├── app
│   ├── assets
│   │   └── stylesheets
│   │       └── pages
│   │           └── _login.scss
│   ├── controllers
│   │   └── application_controller.rb
│   ├── views
│   │   ├── layouts
│   │   │   └── application.html.erb
│   │   ├── pages
│   │   │   └── _login.html.erb
│   │   └── devise
│   │       └── sessions
│   │           └── new.html.erb
├── config
│   └── routes.rb
├── Gemfile
└── README.md
```

## Features
- **User Authentication**: Users can sign up and log in using Devise.
- **Responsive Design**: The application is designed to be responsive and user-friendly.
- **Modal Login**: A login modal that slides in from the right, providing a seamless login experience.

## Setup Instructions
1. **Clone the Repository**: 
   ```
   git clone <repository-url>
   cd NEXT_GIG
   ```

2. **Install Dependencies**: 
   ```
   bundle install
   ```

3. **Set Up Database**: 
   ```
   rails db:create
   rails db:migrate
   ```

4. **Start the Server**: 
   ```
   rails server
   ```

5. **Access the Application**: Open your browser and go to `http://localhost:3000`.

## Usage
- To log in, click the "Login" button in the header. This will trigger a modal that allows users to enter their credentials.
- Users can sign up by clicking the "Sign-up" button, which will redirect them to the sign-up page.

## Contributing
Contributions are welcome! Please submit a pull request or open an issue for any enhancements or bug fixes.

## License
This project is licensed under the MIT License. See the LICENSE file for details.