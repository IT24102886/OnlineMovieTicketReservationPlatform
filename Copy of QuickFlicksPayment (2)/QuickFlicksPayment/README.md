# QuickFlicks Payment System

A Java-based web application for processing payments for the QuickFlicks movie ticket reservation system.

## Features

- Process credit card payments
- Process cash payments
- View payment history
- View payment details
- File-based transaction storage

## Technology Stack

- **Backend**: Java, Spring Boot, Servlets
- **Frontend**: JSP, HTML/CSS, JavaScript, Bootstrap
- **Data Storage**: File-based CRUD (transactions.txt)

## Project Structure

- `src/main/java/com/quickflicks/payment/`
  - `controller/` - Contains controllers for handling HTTP requests
  - `model/` - Contains domain models (Payment, CreditCardPayment, CashPayment)
  - `service/` - Contains business logic and data access

- `src/main/resources/`
  - `static/` - Contains static resources (CSS, JavaScript)
  - `application.properties` - Application configuration

- `src/main/webapp/WEB-INF/views/`
  - JSP views for the application

## Getting Started

### Prerequisites

- Java 11 or higher
- Maven 3.6 or higher

### Running the Application

1. Clone the repository
2. Navigate to the project directory
3. Run the application using Maven:

```bash
mvn spring-boot:run
```

4. Open a web browser and navigate to `http://localhost:8080`

## OOP Concepts Used

- **Encapsulation**: Private fields with getters and setters in model classes
- **Inheritance**: Payment as a base class with CreditCardPayment and CashPayment as subclasses
- **Polymorphism**: Different implementations of processPayment() method
- **Composition**: Service classes using model classes

## File Storage

All transactions are stored in a text file (`transactions.txt`) in CSV format. Each line represents a single transaction with the following fields:

- Transaction ID
- Payment Type
- Amount
- Transaction Date
- Booking ID
- Customer Name
- Status
- Payment-specific fields (depending on payment type)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
