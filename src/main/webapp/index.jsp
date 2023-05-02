<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement,
java.sql.ResultSet, java.sql.DriverManager, java.util.List,
java.util.ArrayList, java.sql.SQLException, com.exp.Expense,
java.sql.Date, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Expenses</title>
	<style>
	table, th, td {
      border: 1px solid black;
      border-collapse: collapse;
    }
    tr:nth-child(even) {
      background-color: #D6EEEE;
    }
    </style>
</head>
<body>

	<h1 align="center">Expenses</h1>
	<table style="width:70%" align="center">
		<tr>
			<th>Category</th>
			<th>Date</th>
			<th>Name</th>
			<th>Description</th>
			<th>Amount</th>
		</tr>
        <c:set var="expenses" value="${null}" />
		<%
			// Import necessary JDBC classes
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/bjit_db";
			String username = "root";
			String password = "";
			List<Expense> expenses = new ArrayList<Expense>();

			Connection connection = null;
			PreparedStatement statement = null;
			ResultSet resultSet = null;

			try {
				// Establish a connection to the database

				connection = DriverManager.getConnection(url, username, password);
                if (request.getParameter("submit") != null) {

                            String category = request.getParameter("category");
                            Date date = Date.valueOf(request.getParameter("date"));
                            String name = request.getParameter("name");
                            String description = request.getParameter("description");
                            double amount = Double.parseDouble(request.getParameter("amount"));

                            String query = "INSERT INTO `expenses` (`expense_id`, `expense_category`, `expense_date`, `expense_name`, `expense_description`, `expense_amount`) VALUES (NULL, ?, ?, ?,?, ?);";
                            statement = connection.prepareStatement(query);
                            statement.setString(1, category);
                            statement.setDate(2, date);
                            statement.setString(3, name);
                            statement.setString(4, description);
                            statement.setDouble(5, amount);
                            statement.executeUpdate();

                        }
				// Prepare a SQL statement to retrieve all expenses sorted by date
				String sql = "SELECT * FROM expenses ORDER BY expense_date ASC";
				statement = connection.prepareStatement(sql);

				// Execute the SQL statement and get the result set
				resultSet = statement.executeQuery();

				// Iterate over the result set and add each expense to the expenses list

				while (resultSet.next()) {
					Expense expense = new Expense(
					    resultSet.getInt("expense_id"),
						resultSet.getString("expense_category"),
						resultSet.getDate("expense_date"),
						resultSet.getString("expense_name"),
						resultSet.getString("expense_description"),
						resultSet.getDouble("expense_amount")
					);
					expenses.add(expense);
				}

				// Set the expenses list as a request attribute

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				// Close the database resources
				if (resultSet != null) {
					try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
				}
				if (statement != null) {
					try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
				}
				if (connection != null) {
					try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
				}
			}
		%>
		<% for (Expense expense : expenses)
		{
		%>
			<tr>
				<td><%=expense.expenseCategory %></td>
				<td><%=expense.expenseDate %></td>
				<td><%=expense.expenseName %></td>
				<td><%=expense.expenseDescription %></td>
				<td><%=expense.expenseAmount %></td>
			</tr>
		<%
        	}
        %>
	</table>
</body>
</html>