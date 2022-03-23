public abstract class ExpensesSelector {

	public static ExpensesSelector i {
		get {
			return withSharingInstance;
		}
	}

	public static ExpensesSelector withSharingInstance {
		get {
			return (ExpensesSelector)DependencyInjector.i.instanceFor(ExpensesSelector.class);
		}
	}

	public static ExpensesSelector withoutSharingInstance {
		get {
			return (ExpensesSelector)DependencyInjector.withoutSharingInstance.instanceFor(ExpensesSelector.class);
		}
	}

	public static ExpensesSelector inheritedSharingInstance {
		get {
			return (ExpensesSelector)DependencyInjector.inheritedSharingInstance.instanceFor(ExpensesSelector.class);
		}
	}

	public abstract List<Expense> selectAll();

	public inherited sharing class InheritedSharingImplementation
			extends ExpensesSelector {

		public override List<Expense> selectAll() {
			return [SELECT Amount, TransactionDate FROM Expense];
		}
	}

	public with sharing class WithSharingImplementation
			extends ExpensesSelector {
		public override List<Expense> selectAll() {
		    return inheritedSharingInstance.selectAll();
		}
	}

	public without sharing class WithoutSharingImplementation
			extends ExpensesSelector {
		public override List<Expense> selectAll() {
		    return inheritedSharingInstance.selectAll();
		}
	}
}
