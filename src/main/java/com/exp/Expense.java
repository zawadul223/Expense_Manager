package com.exp;

import java.math.BigDecimal;
import java.util.Date;

public class Expense implements Comparable<Expense> {
    public int expenseId;
    public String expenseCategory;
    public Date expenseDate;
    public String expenseName;
    public String expenseDescription;
    public double expenseAmount;

    public Expense(int expenseId, String expenseCategory, Date expenseDate, String expenseName, String expenseDescription,
                   double expenseAmount) {
        this.expenseId = expenseId;
        this.expenseCategory = expenseCategory;
        this.expenseDate = expenseDate;
        this.expenseName = expenseName;
        this.expenseDescription = expenseDescription;
        this.expenseAmount = expenseAmount;
    }

    public int getExpenseId() {
        return expenseId;
    }

    public void setExpenseId(int expenseId) {
        this.expenseId = expenseId;
    }

    public String getExpenseCategory() {
        return expenseCategory;
    }

    public void setExpenseCategory(String expenseCategory) {
        this.expenseCategory = expenseCategory;
    }

    public Date getExpenseDate() {
        return expenseDate;
    }

    public void setExpenseDate(Date expenseDate) {
        this.expenseDate = expenseDate;
    }

    public String getExpenseName() {
        return expenseName;
    }

    public void setExpenseName(String expenseName) {
        this.expenseName = expenseName;
    }

    public String getExpenseDescription() {
        return expenseDescription;
    }

    public void setExpenseDescription(String expenseDescription) {
        this.expenseDescription = expenseDescription;
    }

    public double getExpenseAmount() {
        return expenseAmount;
    }

    public void setExpenseAmount(double expenseAmount) {
        this.expenseAmount = expenseAmount;
    }

    @Override
    public int compareTo(Expense otherExpense) {
        return this.expenseDate.compareTo(otherExpense.getExpenseDate());
    }
}