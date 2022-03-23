import { LightningElement } from 'lwc';
import selectAllExpenses from '@salesforce/apex/ExpensesAuraSelector.selectAll';

const Options = {
	withSharing: 'with-sharing',
	withoutSharing: 'without-sharing',
	inheritedSharing: 'inherited-sharing'
}

export default class ViewExpenses extends LightningElement {
	title = 'Expenses';
	expenses = [];

	//async connectedCallback() {
	//	try {
	//		this.expenses = await selectAllExpenses({ option: Options.withSharing });
	//		console.log('sefo', this.expenses);
	//	}
	//	catch (exception) {
	//		console.error('sefo erro!', { exception });
	//	}
	//}

	handleWithSharingClick() {
		this.handleClick('withSharing', Options.withSharing);
	}

	handleWithoutSharingClick() {
		this.handleClick('withoutSharing', Options.withoutSharing);
	}

	async handleClick(title, option) {
		this.title = 'loading ...';
		try {
			this.expenses = await selectAllExpenses({ option });
			this.title = `${title} result:`;
		}
		catch (exception) {
			console.error('sefo erro!', { exception });
			this.expenses = [];
			this.title = `Error on click of ${title}`;
		}
	}
}