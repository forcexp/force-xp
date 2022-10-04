@IsTest
public class CommandTest {
	@IsTest
	static void itShouldThrowExceptionForNotImplementedExecuteMethod() {
		Exception caughtException = null;
		Command command = new NotImplementedCommand();

		try {
			command.onExecute();
		} catch (Exception e) {
			caughtException = e;
		}

		System.assertNotEquals(
			null,
			caughtException,
			'A exception should have been caught.'
		);
		System.assert(
			caughtException instanceof NotImplementedException,
			'A exception of type NotImplementedException should have been caught.'
		);
	}

	@IsTest
	static void itShouldThrowExceptionForNotImplementedUndoMethod() {
		Exception caughtException = null;
		Command command = new NotImplementedCommand();

		try {
			command.onUndo();
		} catch (Exception e) {
			caughtException = e;
		}

		System.assertNotEquals(
			null,
			caughtException,
			'A exception should have been caught.'
		);
		System.assert(
			caughtException instanceof NotImplementedException,
			'A exception of type NotImplementedException should have been caught.'
		);
	}

	@IsTest
	static void itShouldThrowExceptionOnUndoingNotExecutedCommand() {
		Exception caughtException = null;
		Command command = new DummyCommand();

		try {
			command.undo();
		} catch (Exception e) {
			caughtException = e;
		}

		System.assertNotEquals(
			null,
			caughtException,
			'A exception should have been caught.'
		);
		System.assert(
			caughtException instanceof Command.CommandNeverExecutedException,
			'A exception of type Command.CommandNeverExecutedException should have been caught.'
		);
	}

	@IsTest
	static void itShouldThrowExceptionOnExecutingACommandAlradyExecuted() {
		Exception caughtException = null;
		Command command = new DummyCommand();
		command.setToExecuteWithoutSharing();
		command.execute();

		try {
			command.execute();
		} catch (Exception e) {
			caughtException = e;
		}

		System.assertNotEquals(
			null,
			caughtException,
			'A exception should have been caught.'
		);
		System.assert(
			caughtException instanceof Command.CommandAlreadyExecutedException,
			'A exception of type Command.CommandNeverExecutedException should have been caught.'
		);
	}

	@IsTest
	static void itShouldUndoTheExecutedCommand() {
		Exception caughtException = null;
		Command command = new DummyCommand();
		command.setToExecuteWithSharing();
		command.execute();

		try {
			command.undo();
		} catch (Exception e) {
			caughtException = e;
		}

		System.assertEquals(
			null,
			caughtException,
			'A exception should NOT have been caught.'
		);
	}

	@IsTest
	static void itShouldExecuteTheCommand() {

		DummyCommand command = new DummyCommand();

		command.execute();


		System.assertEquals(
			true,
			command.wasExecuted,
			'The command should have been executed.'
		);
	}

	class NotImplementedCommand extends Command {
	}

	class DummyCommand extends Command {

		Boolean wasExecuted = false;

		protected override void onExecute() {
			wasExecuted = true;
		}

		protected override void onUndo() {
			System.debug('Testing undo() of DummyCommand.');
		}
	}
}
