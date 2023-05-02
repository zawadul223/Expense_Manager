import com.exp.Expense;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ShowExpensesServlet")
public class ShowExpensesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Expense> expenses = new ArrayList<>();

        // Retrieve the data from the database
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bjit_db", "username", "password");
            String sql = "SELECT * FROM expenses";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int expenseId = rs.getInt("expense_id");
                String expenseCategory = rs.getString("expense_category");
                Date expenseDate = rs.getDate("expense_date");
                String expenseName = rs.getString("expense_name");
                String expenseDescription = rs.getString("expense_description");
                double expenseAmount = rs.getDouble("expense_amount");

                expenses.add(new Expense(expenseId, expenseCategory, expenseDate, expenseName, expenseDescription, expenseAmount));
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        // Sort the list by date
        Collections.sort(expenses);

        // Forward the request to the JSP page
        request.setAttribute("expenses", expenses);
        request.getRequestDispatcher("expenses.jsp").forward(request, response);
    }
}