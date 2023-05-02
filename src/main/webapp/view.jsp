<!DOCTYPE html>
<html>
<head>
    <title>Expense Management</title>
</head>
<body>
<h1>Welcome to my JSP Page</h1>


<form action="index.jsp" method="post">
    <label for="expense-category">Expense Category:</label>
    <select id="expense-category" name="category">
        <option value="Transportation">Transportation</option>
        <option value="Food">Food</option>
        <option value="Fees">Fees</option>
        <option value="Bills">Bills</option>
        <option value="Entertainment">Entertainment</option>
    </select><br><br>

    <label for="expense-date">Date:</label>
    <input type="date" id="expense-date" name="date"><br><br>

    <label for="expense-name" >Expense Name:</label>
    <input type="text" id="expense-name" name="name"><br><br>

    <label for="expense-description">Description:</label>
    <textarea id="expense-description" name="description"></textarea><br><br>

    <label for="expense-amount">Amount:</label>
    <input type="number" id="expense-amount" step="0.01" name="amount"><br><br>

    <input type="submit" value="Submit">
</form>


</body>
</html>