<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.exp.Expense" %>

<%
    String url = "jdbc:mysql://localhost:3306/bjit_db";
    String username = "root";
    String password = "";

    try {
        // Connect to the database
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, username, password);

        // If the form was submitted, add a new expense to the database
        if (request.getParameter("submit") != null) {
            String category = request.getParameter("category");
            Date date = Date.valueOf(request.getParameter("date"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double amount = Double.parseDouble(request.getParameter("amount"));

            String query = "INSERT INTO expenses (category, date, name, description, amount) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, category);
            statement.setDate(2, date);
            statement.setString(3, name);
            statement.setString(4, description);
            statement.setDouble(5, amount);
            statement.executeUpdate();
        }

        // Get all expenses from the database
        String query = "SELECT * FROM expenses";
        Statement statement = conn.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Create a list of expenses to store the results
        List<Expense> expenses = new ArrayList<Expense>();
        while (resultSet.next()) {
            Expense expense = new Expense(
                resultSet.getInt("Id"),
                resultSet.getString("category"),
                resultSet.getDate("date"),
                resultSet.getString("name"),
                resultSet.getString("description"),
                resultSet.getDouble("amount")
            );
            expenses.add(expense);
        }

        // Close the database connection
        conn.close();

        // Display the expenses in a table
%>
        <html>
        <head>
            <title>Expenses</title>
        </head>
        <body>
            <h1>Add Expense</h1>
            <form method="post">
                <label>Category:</label>
                <input type="text" name="category"><br>
                <label>Date:</label>
                <input type="date" name="date"><br>
                <label>Name:</label>
                <input type="text" name="name"><br>
                <label>Description:</label>
                <input type="text" name="description"><br>
                <label>Amount:</label>
                <input type="number" name="amount"><br>
                <input type="submit" name="submit" value="Add Expense">
            </form>
            <h1>Expenses</h1>
            <table>
                <tr>
                    <th>Category</th>
                    <th>Date</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Amount</th>
                </tr>
<%
                for (Expense expense : expenses) {
%>
                    <tr>
                        <td><%= expense.getCategory() %></td>
                        <td><%= expense.getDate() %></td>
                        <td><%= expense.getName() %></td>
                        <td><%= expense.getDescription() %></td>
                        <td><%= expense.getAmount() %></td>
                    </tr>
<%
                }
%>
            </table>
        </body>
        </html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>