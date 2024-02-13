# OnlineFitness - Advisor Application (Dynamic Web Project with JSP)

This project is a dynamic web application developed using JSP (JavaServer Pages) technology. It serves as the backend for the OnlineFitness system, providing various functionalities implemented through packages such as bean, dao, mysql, and util.

## Project Structure

- **dto**: This package contains Data Transfer Objects (DTOs) used for communication between different layers of the application.
- **beans**: This package contains Plain Old Java Objects (POJOs) representing entities or data objects used in the application for data manipulation.
- **dao**: Data Access Object (DAO) package contains interfaces and implementations for database access using the DAO design pattern.
- **mysql**: MySQL package contains implementations of DAO interfaces for MySQL database interaction.
- **util**: Util package contains utility classes, including database connection utilities for connecting to the MySQL database.
- **web**: This package contains resources related to the web interface of the application.
  - **WebContent**: Directory for web resources.
    - **images**: Directory for image files used in the application.
    - **styles**: Directory for CSS files used in the application.
    - **js**: Directory for JavaScript files used in the application.
    - **WEB-INF/web.xml**: Configuration file for the web application.


## Running the Application

To run the application, you can deploy it on a servlet container such as Apache Tomcat or run it within your IDE. Ensure that you have configured the appropriate database connection properties.

## Dependencies

Ensure that you have the necessary dependencies added to your project, including the servlet API and MySQL Connector/J.

## Building Instructions

This project can be built using Apache Ant. Run the appropriate Ant targets to compile the Java source files and package the application into a WAR (Web Application Archive) file.

## Database Configuration

Ensure that MySQL is installed and running on your system. Update the database connection properties in the util/ConnectionPool.properties file to match your MySQL configuration.

## GUI Development

The GUI for this application is developed using JSP (JavaServer Pages), and Bootstrap framework is utilized for styling. JSP files can be found in the `WebContent` directory, where you can customize these files to modify the user interface according to your requirements. Bootstrap CSS and JavaScript files are located in the `bootstrap` directory within `WebContent`, providing a responsive and visually appealing design for the application.

## Additional Information

For more information about JSP, servlets, and MySQL, refer to the official documentation:
- [JavaServer Pages (JSP) Documentation](https://javaee.github.io/javaee-spec/javadocs/javax/servlet/jsp/package-summary.html)
- [Servlets Documentation](https://javaee.github.io/javaee-spec/javadocs/javax/servlet/package-summary.html)
- [MySQL Documentation](https://dev.mysql.com/doc/)

## Application Screenshots

![image](https://github.com/frke001/Task-scheduler-and-parallel-processing-of-multimedia-data/assets/93668747/a92a9a90-5f90-460a-a57d-8fbeae5428ec)
![image](https://github.com/frke001/Task-scheduler-and-parallel-processing-of-multimedia-data/assets/93668747/589c3d48-117e-4eee-bc1d-9291fb137b6a)

