import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/add")
public class AddExpenseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("get called");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the form data
        String expenseCategory = request.getParameter("expense_category");
        String expenseDateStr = request.getParameter("expense_date");
        String expenseName = request.getParameter("expense_name");
        String expenseDescription = request.getParameter("expense_description");
        BigDecimal expenseAmount = new BigDecimal(request.getParameter("expense_amount"));

        // Parse the expense date
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date expenseDate = null;
        try {
            expenseDate = dateFormat.parse(expenseDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}