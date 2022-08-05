public inherited sharing class ExpensesAuraSelector {
	@AuraEnabled
	public static List<Expense> selectAll(String option) {
		ExpensesSelector selector = null;

		if (option == 'with-sharing')
			selector = ExpensesSelector.i;

		return selector.selectAll();
	}
}
